package onBoardingHcUi
{
    import flash.display.DisplayObject;
    import flash.display.Bitmap;
    import flash.geom.Rectangle;

    public class ColouredButton extends Button 
    {

        private static const button_green_png:Class = HabboColouredButton_button_green_png;
        private static const button_green_pressed_png:Class = HabboColouredButton_button_green_pressed_png;
        private static const button_green_inactive_png:Class = HabboColouredButton_button_green_inactive_png;
        private static const button_green_rollover_png:Class = HabboColouredButton_button_green_rollover_png;
        private static const button_red_png:Class = HabboColouredButton_button_red_png;
        private static const button_red_pressed_png:Class = HabboColouredButton_button_red_pressed_png;
        private static const button_red_rollover_png:Class = HabboColouredButton_button_red_rollover_png;
        private static const button_red_inactive_png:Class = HabboColouredButton_button_red_inactive_png;
        private static const button_yellow_png:Class = HabboColouredButton_button_yellow_png;
        private static const button_yellow_pressed_png:Class = HabboColouredButton_button_yellow_pressed_png;
        private static const button_yellow_rollover_png:Class = HabboColouredButton_button_yellow_rollover_png;
        private static const button_yellow_inactive_png:Class = HabboColouredButton_button_yellow_inactive_png;
        private static const icon_hc:Class = HabboColouredButton_Habboicon_hc_png;
        public static const BUTTON_RED:String = "red";
        public static const BUTTON_GREEN:String = "gfreen";
        public static const BUTTON_YELLOW:String = "yellow";

        private var _defaultBackground:DisplayObject;
        private var _pressedBackground:DisplayObject;
        private var _inactiveBackground:DisplayObject;
        private var _rolloverBackground:DisplayObject;
        private var _icon:Bitmap;

        public function ColouredButton(_arg_1:String, _arg_2:String, _arg_3:Rectangle, _arg_4:Boolean, _arg_5:Function, _arg_6:uint=0xFFFFFF)
        {
            switch (_arg_1)
            {
                case "red":
                    _defaultBackground = LoaderUI.createScale9GridShapeFromImage(Bitmap(new button_red_png()).bitmapData, new Rectangle(8, 10, 6, 4));
                    _pressedBackground = LoaderUI.createScale9GridShapeFromImage(Bitmap(new button_red_pressed_png()).bitmapData, new Rectangle(8, 10, 6, 4));
                    _inactiveBackground = LoaderUI.createScale9GridShapeFromImage(Bitmap(new button_red_inactive_png()).bitmapData, new Rectangle(8, 10, 6, 4));
                    _rolloverBackground = LoaderUI.createScale9GridShapeFromImage(Bitmap(new button_red_rollover_png()).bitmapData, new Rectangle(8, 10, 6, 4));
                    break;
                case "gfreen":
                    _defaultBackground = LoaderUI.createScale9GridShapeFromImage(Bitmap(new button_green_png()).bitmapData, new Rectangle(8, 10, 6, 4));
                    _pressedBackground = LoaderUI.createScale9GridShapeFromImage(Bitmap(new button_green_pressed_png()).bitmapData, new Rectangle(8, 10, 6, 4));
                    _inactiveBackground = LoaderUI.createScale9GridShapeFromImage(Bitmap(new button_green_inactive_png()).bitmapData, new Rectangle(8, 10, 6, 4));
                    _rolloverBackground = LoaderUI.createScale9GridShapeFromImage(Bitmap(new button_green_rollover_png()).bitmapData, new Rectangle(8, 10, 6, 4));
                    break;
                case "yellow":
                    _defaultBackground = LoaderUI.createScale9GridShapeFromImage(Bitmap(new button_yellow_png()).bitmapData, new Rectangle(8, 10, 6, 4));
                    _pressedBackground = LoaderUI.createScale9GridShapeFromImage(Bitmap(new button_yellow_pressed_png()).bitmapData, new Rectangle(8, 10, 6, 4));
                    _inactiveBackground = LoaderUI.createScale9GridShapeFromImage(Bitmap(new button_yellow_inactive_png()).bitmapData, new Rectangle(8, 10, 6, 4));
                    _rolloverBackground = LoaderUI.createScale9GridShapeFromImage(Bitmap(new button_yellow_rollover_png()).bitmapData, new Rectangle(8, 10, 6, 4));
                    _icon = Bitmap(new icon_hc());
            };
            super(_arg_2, _arg_3, _arg_4, _arg_5, _arg_6);
        }

        override protected function get defaultBackground():DisplayObject
        {
            return (_defaultBackground);
        }

        override protected function get pressedBackground():DisplayObject
        {
            return (_pressedBackground);
        }

        override protected function get inactiveBackground():DisplayObject
        {
            return (_inactiveBackground);
        }

        override protected function get rolloverBackground():DisplayObject
        {
            return (_rolloverBackground);
        }

        override protected function get etching():Boolean
        {
            return (false);
        }

        override protected function get padding():int
        {
            return (64);
        }

        override protected function get textColour():uint
        {
            return (0xFFFFFF);
        }

        override protected function get icon():Bitmap
        {
            return (_icon);
        }


    }
}