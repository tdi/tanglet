lessThan(QT_VERSION, 4.6) {
	error("Tanglet requires Qt 4.6 or greater")
}

TEMPLATE = app
greaterThan(QT_MAJOR_VERSION, 4):QT += widgets
CONFIG += warn_on

# Add dependencies
macx {
	LIBS += -lz
} else:win32 {
	greaterThan(QT_MAJOR_VERSION, 4) {
		LIBS += -lz
	}
} else:unix {
	CONFIG += link_pkgconfig
	PKGCONFIG += zlib
}

# Allow in-tree builds
MOC_DIR = build
OBJECTS_DIR = build
RCC_DIR = build

# Set program version
VERSION = 1.2.2
DEFINES += VERSIONSTR=\\\"$${VERSION}\\\"

# Set program name
unix:!macx {
	TARGET = tanglet
} else {
	TARGET = Tanglet
}

# Specify program sources
HEADERS += src/beveled_rect.h \
	src/board.h \
	src/clock.h \
	src/generator.h \
	src/gzip.h \
	src/language_dialog.h \
	src/language_settings.h \
	src/locale_dialog.h \
	src/letter.h \
	src/new_game_dialog.h \
	src/random.h \
	src/scores_dialog.h \
	src/solver.h \
	src/trie.h \
	src/view.h \
	src/window.h \
	src/word_counts.h \
	src/word_tree.h

SOURCES += src/beveled_rect.cpp \
	src/board.cpp \
	src/clock.cpp \
	src/generator.cpp \
	src/gzip.cpp \
	src/language_dialog.cpp \
	src/language_settings.cpp \
	src/locale_dialog.cpp \
	src/letter.cpp \
	src/new_game_dialog.cpp \
	src/main.cpp \
	src/random.cpp \
	src/scores_dialog.cpp \
	src/solver.cpp \
	src/trie.cpp \
	src/view.cpp \
	src/window.cpp \
	src/word_counts.cpp \
	src/word_tree.cpp

# Allow for updating translations
TRANSLATIONS = $$files(translations/tanglet_*.ts)

# Install program data
RESOURCES = icons/icons.qrc data.qrc

macx {
	ICON = icons/tanglet.icns

	GAME_DATA.files = data
	GAME_DATA.path = Contents/Resources

	QMAKE_BUNDLE_DATA += GAME_DATA
} else:win32 {
	RC_FILE = icons/icon.rc
} else:unix {
	isEmpty(PREFIX) {
		PREFIX = /usr/local
	}
	isEmpty(BINDIR) {
		BINDIR = bin
	}

	target.path = $$PREFIX/$$BINDIR/

	data.files = data/*
	data.path = $$PREFIX/share/tanglet/data/

	icon.files = icons/hicolor/*
	icon.path = $$PREFIX/share/icons/hicolor/

	pixmap.files = icons/tanglet.xpm
	pixmap.path = $$PREFIX/share/pixmaps/

	desktop.files = icons/tanglet.desktop
	desktop.path = $$PREFIX/share/applications/

	qm.files = translations/*.qm
	qm.path = $$PREFIX/share/tanglet/translations

	man.files = doc/tanglet.6
	man.path = $$PREFIX/share/man/man6

	INSTALLS += target icon pixmap desktop data qm man
}
