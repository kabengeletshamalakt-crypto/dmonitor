# ============================================================
# WEB APP - Analyse Univariée Monitoring Système
# ============================================================

import streamlit as st
import pandas as pd
import numpy as np
import plotly.graph_objects as go
from plotly.subplots import make_subplots

st.set_page_config(layout="wide")

st.title("📊 Dashboard Univarié - Monitoring Système")

# -----------------------------
# Upload fichier
# -----------------------------
uploaded_file = st.file_uploader("Uploader votre fichier CSV", type=["csv"])

if uploaded_file is not None:

    df = pd.read_csv(uploaded_file)

    # Nettoyage
    df.columns = df.columns.str.replace("%", "", regex=False)

    if "datetime" in df.columns:
        df["datetime"] = pd.to_datetime(df["datetime"])

    st.success("Fichier chargé avec succès")

    # Sélection variable
    variables_numeriques = df.select_dtypes(include=np.number).columns
    if "timestamp" in variables_numeriques:
        variables_numeriques = variables_numeriques.drop("timestamp")

    variable = st.selectbox("Choisir une variable à analyser", variables_numeriques)

    serie = df[variable].dropna()

    # -----------------------------
    # Statistiques
    # -----------------------------
    st.subheader("📈 Statistiques descriptives")

    col1, col2, col3 = st.columns(3)

    col1.metric("Moyenne", round(serie.mean(), 2))
    col2.metric("Médiane", round(serie.median(), 2))
    col3.metric("Écart-type", round(serie.std(), 2))

    st.write("Variance :", serie.var())
    st.write("Skewness :", serie.skew())
    st.write("Kurtosis :", serie.kurt())

    # -----------------------------
    # Dashboard
    # -----------------------------
    fig = make_subplots(
        rows=2, cols=2,
        subplot_titles=(
            "Série temporelle",
            "Histogramme",
            "Boxplot",
            "Distribution cumulée"
        )
    )

    # Série temporelle
    if "datetime" in df.columns:
        fig.add_trace(
            go.Scatter(
                x=df["datetime"],
                y=serie,
                mode="lines"
            ),
            row=1, col=1
        )

    # Histogramme
    fig.add_trace(
        go.Histogram(x=serie, nbinsx=20),
        row=1, col=2
    )

    # Boxplot
    fig.add_trace(
        go.Box(y=serie),
        row=2, col=1
    )

    # Distribution cumulée
    fig.add_trace(
        go.Histogram(x=serie, cumulative_enabled=True, nbinsx=20),
        row=2, col=2
    )

    fig.update_layout(height=800, width=1200, showlegend=False)

    st.plotly_chart(fig, use_container_width=True)

else:
    st.info("Veuillez uploader un fichier CSV pour commencer.")
