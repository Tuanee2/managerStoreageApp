import QtQuick 2.15

Item {
    anchors.fill: parent

    property var dataPoints: [20, 12, 15, 23, 30, 5, 9, 18, 27, 21, 3, 17, 23, 26, 11, 14, 22, 17, 8, 10, 27, 30, 24, 12, 15]
    property string xUnit: ""
    property string yUnit: ""

    Rectangle {
        width: parent.width*0.9
        height: parent.height*0.9
        radius: 10
        color: "transparent"
        clip: true
        Canvas {
            anchors.fill: parent
            onPaint: {
                var ctx = getContext("2d");
                ctx.clearRect(0, 0, width, height);
                ctx.fillStyle = "rgba(255,255,255,0.5)";
                ctx.fillRect(0, 0, width, height);
                var maxVal = 0;
                for (var i = 0; i < dataPoints.length; i++) {
                    if (dataPoints[i] > maxVal)
                        maxVal = dataPoints[i];
                }
                var spacing = 4;
                var columnWidth = ((width - 30) / Math.min(31, dataPoints.length));

                ctx.strokeStyle = "black";
                ctx.lineWidth = 1;
                // Trục Y
                ctx.beginPath();
                ctx.moveTo(30, 0);
                ctx.lineTo(30, height - 20);
                ctx.stroke();

                // Trục X
                ctx.beginPath();
                ctx.moveTo(30, height - 20);
                ctx.lineTo(width, height - 20);
                ctx.stroke();

                // Hiển thị đơn vị
                ctx.fillStyle = "black";
                ctx.font = "12px sans-serif";
                ctx.fillText(yUnit, 5, 10);
                ctx.fillText(xUnit, width - 40, height - 5);

                // Vẽ cột
                for (var i = 0; i < Math.min(31, dataPoints.length); i++) {
                    var value = dataPoints[i];
                    var barHeight = (value / maxVal) * (height - 30); // trừ khoảng cho trục
                    var x = i * columnWidth + 30 + spacing / 2;
                    var y = height - 20 - barHeight;
                    var centerX = x + (columnWidth - spacing) / 2;
                    var gradient = ctx.createLinearGradient(x, y, x + (columnWidth - spacing), y);

                    if(value / maxVal >= 0.75){
                        gradient.addColorStop(0, "rgba(0, 200, 250, 0.2)");     // Trái tối hơn
                        gradient.addColorStop(0.2, "rgba(0, 200, 250, 0.6)");  // Cận sáng
                        gradient.addColorStop(0.5, "white");                   // Tâm sáng nhất
                        gradient.addColorStop(0.8, "rgba(0, 200, 250, 0.6)");
                        gradient.addColorStop(1, "rgba(0, 200, 250, 0.2)");     // Phải tối lại
                    }else if ((value / maxVal < 0.75) && (value / maxVal >= 0.5)){

                        gradient.addColorStop(0, "rgba(0, 255, 100, 0.2)");     // Trái tối hơn
                        gradient.addColorStop(0.2, "rgba(0, 255, 100, 0.6)");  // Cận sáng
                        gradient.addColorStop(0.5, "rgba(255, 255, 255, 0.8)");                   // Tâm sáng nhất
                        gradient.addColorStop(0.8, "rgba(0, 255, 100, 0.6)");
                        gradient.addColorStop(1, "rgba(0, 255, 100, 0.2)");     // Phải tối lại
                    }else if ((value / maxVal < 0.5) && (value / maxVal >= 0.25)){
                        gradient.addColorStop(0, "rgba(255, 150, 0, 0.2)");     // Trái tối hơn
                        gradient.addColorStop(0.2, "rgba(255, 150, 0, 0.6)");  // Cận sáng
                        gradient.addColorStop(0.5, "white");                   // Tâm sáng nhất
                        gradient.addColorStop(0.8, "rgba(255, 150, 0, 0.6)");
                        gradient.addColorStop(1, "rgba(255, 150, 0, 0.2)");     // Phải tối lại
                    }else {
                        gradient.addColorStop(0, "rgba(255, 50, 50, 0.2)");     // Trái tối hơn
                        gradient.addColorStop(0.2, "rgba(255, 50, 50, 0.6)");  // Cận sáng
                        gradient.addColorStop(0.5, "white");                   // Tâm sáng nhất
                        gradient.addColorStop(0.8, "rgba(255, 50, 50, 0.6)");
                        gradient.addColorStop(1, "rgba(255, 50, 50, 0.2)");     // Phải tối lại
                    }
                    ctx.fillStyle = gradient;
                    ctx.fillRect(x, y, columnWidth - spacing, barHeight);
                }
            }
        }
    }
}
