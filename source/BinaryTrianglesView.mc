using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Lang as Lang;
using Toybox.Application as App;

class BinaryTrianglesView extends Ui.WatchFace {

	hidden var propBackgroundColor;

	hidden var marginFactor = 0.1;
	hidden var startX;
	hidden var endX;
	hidden var totalWidth;
	hidden var startY;
	hidden var endY;
	hidden var totalHeight;
	
	hidden var triangleWidth;
	hidden var halfTriangleWidth;
	hidden var lineHeight;

    function initialize() {
        WatchFace.initialize();
        self.updateUserSettings();
    }
    
    function updateUserSettings() {
        var app = App.getApp();
        propBackgroundColor = (app.getProperty("BackgroundColor") == null) ? 0 : app.getProperty("BackgroundColor").toNumber();
    }

    // Load your resources here
    function onLayout(dc) {
    	var margin = Math.round(dc.getWidth() * marginFactor);
		startX = margin;
		startY = margin;
		endX = dc.getWidth() - margin;
		endY = dc.getHeight() - margin;
		totalWidth = endX - startX;
		totalHeight = endY - startY;
		
		triangleWidth = Math.round(totalWidth / 3);
		halfTriangleWidth = Math.round(triangleWidth / 2);
		lineHeight = Math.round(totalHeight / 3);
		
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    }

    // Update the view
    function onUpdate(dc) {
    	View.onUpdate(dc);
    	
    	dc.setColor(0xFF0000, propBackgroundColor);
    	dc.clear();
    	
    	drawBackground(dc);
    }
    
    function drawBackground(dc) {
    	drawRow(dc, 0);
    }
    
    function drawRow(dc, index) {
    	var triangleMargin = 6;
    	drawTriangle(dc, true, 0, startY, 0xFF0000, halfTriangleWidth, triangleMargin);
    	drawTriangle(dc, false, 1, startY, 0x0000FF, halfTriangleWidth, triangleMargin);
    	drawTriangle(dc, true, 1, startY, 0xFF0000, halfTriangleWidth, triangleMargin);
    	    
    	drawTriangle(dc, true, 0, startY + lineHeight, 0xFF0000, 0, triangleMargin);
    	drawTriangle(dc, false, 1, startY  + lineHeight, 0x0000FF, 0, triangleMargin);
    	drawTriangle(dc, true, 1, startY  + lineHeight, 0xFF0000, 0, triangleMargin);
    	drawTriangle(dc, false, 2, startY  + lineHeight, 0x0000FF, 0, triangleMargin);
    	drawTriangle(dc, true, 2, startY  + lineHeight, 0xFF0000, 0, triangleMargin);
    	
    	drawTriangle(dc, false, 0, startY + 2 * lineHeight, 0x0000FF, halfTriangleWidth, triangleMargin);
    	drawTriangle(dc, true, 0, startY + 2 * lineHeight, 0xFF0000, halfTriangleWidth, triangleMargin);
    	drawTriangle(dc, false, 1, startY + 2 * lineHeight, 0x0000FF, halfTriangleWidth, triangleMargin);
    	drawTriangle(dc, true, 1, startY + 2 * lineHeight, 0xFF0000, halfTriangleWidth, triangleMargin);
    	drawTriangle(dc, false, 2, startY + 2 * lineHeight, 0x0000FF, halfTriangleWidth, triangleMargin);
    }
    
    function drawTriangle(dc, tipOnTop, index, rowY, color, marginX, triangleMargin) {
    	var p1;
    	var p2;
    	var p3;
    	
    	var totalMargin = index * triangleWidth + marginX;
    	dc.setColor(color, propBackgroundColor);
    	
    	if(tipOnTop == true) {
    		// bottom left point
    		p1 = [startX + totalMargin + triangleMargin, rowY + lineHeight - triangleMargin];
    		// top middle point
    		p2 = [startX + halfTriangleWidth + totalMargin, rowY + triangleMargin];
    		// bottom right point
    		p3 = [startX + triangleWidth + totalMargin - triangleMargin, rowY + lineHeight - triangleMargin];
    	} else {
    		// bottom middle point
   			p1 = [startX + totalMargin, rowY + lineHeight - triangleMargin];
   			// top left point
   			p2 = [startX + totalMargin - halfTriangleWidth + triangleMargin, rowY + triangleMargin];
   			// top right point
   			p3 = [startX + totalMargin + halfTriangleWidth - triangleMargin, rowY + triangleMargin];
    	}
    	
    	dc.fillPolygon([p2, p1, p3]);
    	
    	
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() {
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() {
    }

}
