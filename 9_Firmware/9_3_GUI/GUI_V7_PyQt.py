#!/usr/bin/env python3
"""
PLFM Radar System GUI V7 — PyQt6 Edition

Entry point.  Launches the RadarDashboard main window.

Usage:
    python GUI_V7_PyQt.py
"""

import sys
import logging

from PyQt6.QtWidgets import QApplication
from PyQt6.QtGui import QFont

from v7 import RadarDashboard

logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s  %(levelname)-8s  %(name)s  %(message)s",
)
logger = logging.getLogger(__name__)


def main():
    app = QApplication(sys.argv)
    app.setApplicationName("PLFM Radar System V7")
    app.setApplicationVersion("7.0.0")
    app.setFont(QFont("Segoe UI", 10))

    window = RadarDashboard()
    window.show()

    logger.info("PLFM Radar GUI V7 started")
    sys.exit(app.exec())


if __name__ == "__main__":
    main()
