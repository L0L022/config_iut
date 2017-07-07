import QtQuick 2.8
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

Item {
    id: item1

    ColumnLayout {
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter

        Label {
            id: label1
            text: qsTr("The Dark Side")
            Layout.preferredHeight: 51
            Layout.preferredWidth: 267
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            fontSizeMode: Text.Fit
            font.pointSize: 40
        }

        RowLayout {
            Layout.alignment: Qt.AlignRight | Qt.AlignVCenter

            Label {
                id: label
                text: qsTr("Installer")
                font.italic: true
                font.bold: true
                font.pointSize: 12
                fontSizeMode: Text.Fit
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }

            RoundButton {
                id: roundButton
                text: "↓"
                highlighted: true
                onClicked: stagesSystem.next()
            }
        }
    }

}
