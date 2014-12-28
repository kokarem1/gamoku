import QtQuick 2.0

Circle {
    property int whichIs

    color: whichIs? "black": "white"
    gradient: whichIs? blackGradient: whiteGradient

    Gradient {
        id: blackGradient

        GradientStop { position: 0.0; color: "black" }
        GradientStop { position: 0.33; color: "#111111" }
        GradientStop { position: 1.0; color: "black" }
    }

    Gradient {
        id: whiteGradient

        GradientStop { position: 0.0; color: "white" }
        GradientStop { position: 0.33; color: "#FFEEEE" }
        GradientStop { position: 1.0; color: "white" }
    }
}
