// Language mode switch
japanese_mode = true;  // Set to false for English text

// Messages
japanese_message = "日本沖縄";
english_message = "Japan Okinawa";

// Font settings
japanese_font = "Hiragino Mincho ProN";
english_font = "Liberation Sans";  // A common font for English
font_size = 12;
font_thickness = 5;

// Keychain dimensions
stick_thickness = 3;
stick_width = 20;
hole_radius = 3;
flat_bottom = 1; //[1:Yes,2:No]
buffer = 10;

// Select message and font based on mode
message = japanese_mode ? japanese_message : english_message;
font = japanese_mode ? japanese_font : english_font;

// Calculate text size for baseplate
// Different multipliers for Japanese and English
text_width = japanese_mode ? 
    len(message) * font_size * 1.5 :  // Japanese spacing
    len(message) * font_size * 0.7;   // English spacing

// Main assembly
translate([0, 0, font_thickness/2]) {
    union() {
        // Text with proper centering
        translate([0, 0, 0])
            linear_extrude(height = font_thickness, center = true)
                text(message, 
                     size = font_size, 
                     font = font, 
                     halign = "center", 
                     valign = "center");
        
        // Baseplate
        if (flat_bottom == 1)
            translate([0, 0, -font_thickness/2 + stick_thickness/2])
                flatstickwithhole();
        
        if (flat_bottom == 2)
            flatstickwithhole();
    }
}

module flatstickwithhole() {
    difference() {
        union() {
            // Main plate
            translate([0, 0, 0])
                cube([text_width + buffer, stick_width, stick_thickness], 
                     center = true);
            
            // End circle
            translate([-text_width/2 - buffer/2, 0, 0])
                cylinder(r = stick_width/2, 
                        h = stick_thickness, 
                        center = true, 
                        $fn = 50);
        }
        
        // Hole
        translate([-text_width/2 - buffer/2, 0, 0])
            cylinder(r = hole_radius, 
                    h = stick_thickness + 2, 
                    center = true, 
                    $fn = 50);
    }
}
