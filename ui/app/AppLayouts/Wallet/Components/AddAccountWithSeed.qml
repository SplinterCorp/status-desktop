import QtQuick 2.12
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import "../../../../imports"
import "../../../../shared"

ModalPopup {
    id: popup
    title: qsTr("Add account with a seed phrase")
    height: 600

    property int marginBetweenInputs: 38
    property string selectedColor: Constants.accountColors[0]

    onOpened: {
        passwordInput.text = ""
        passwordInput.forceActiveFocus(Qt.MouseFocusReason)
    }

    Input {
        id: passwordInput
        placeholderText: qsTr("Enter your password…")
        label: qsTr("Password")
        textField.echoMode: TextInput.Password
    }


    Input {
        id: accountSeedInput
        anchors.top: passwordInput.bottom
        anchors.topMargin: marginBetweenInputs
        placeholderText: qsTr("Enter your seed phrase, separate words with commas or spaces...")
        label: qsTr("Seed phrase")
        isTextArea: true
        customHeight: 88
    }

    Input {
        id: accountNameInput
        anchors.top: accountSeedInput.bottom
        anchors.topMargin: marginBetweenInputs
        placeholderText: qsTr("Enter an account name...")
        label: qsTr("Account name")
    }

    Input {
        id: accountColorInput
        anchors.top: accountNameInput.bottom
        anchors.topMargin: marginBetweenInputs
        bgColor: selectedColor
        label: qsTr("Account color")
        selectOptions: Constants.accountColors.map(color => {
            return {
                text: "",
                bgColor: color,
                height: 52,
                onClicked: function () {
                    selectedColor = color
                }
           }
        })
    }

    footer: StyledButton {
        anchors.top: parent.top
        anchors.topMargin: Theme.padding
        anchors.right: parent.right
        anchors.rightMargin: Theme.padding
        label: "Add account >"

        disabled: passwordInput.text === "" || accountNameInput.text === "" || accountSeedInput.textAreaText === ""

        onClicked : {
            // TODO add message to show validation errors
            if (passwordInput.text === "" || accountNameInput.text === "" || accountSeedInput.textAreaText === "") return;

            walletModel.addAccountsFromSeed(accountSeedInput.textAreaText, passwordInput.text, accountNameInput.text, selectedColor)
            // TODO manage errors adding account
            popup.close();
        }
    }
}

/*##^##
Designer {
    D{i:0;formeditorColor:"#ffffff";height:500;width:400}
}
##^##*/