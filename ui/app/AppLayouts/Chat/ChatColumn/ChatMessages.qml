import QtQuick 2.3
import QtQuick.Controls 2.3
import QtQuick.Controls 2.12 as QQC2
import QtQuick.Layouts 1.3
import Qt.labs.platform 1.1
import "../../../../shared"
import "../../../../imports"

ListView {
    id: chatLogView
    model: chatsModel.messageList
    Layout.fillWidth: true
    Layout.fillHeight: true
    delegate: Message {}
    highlightFollowsCurrentItem: true

    onCountChanged: {
        if (!this.atYEnd) {
            // User has scrolled up, we don't want to scroll back
            return
        }

        // positionViewAtEnd doesn't work well. Instead, we use highlightFollowsCurrentItem
        // and set the current Item/Index to the latest item
        while (this.currentIndex < this.count - 1) {
            this.incrementCurrentIndex()
        }
    }
}