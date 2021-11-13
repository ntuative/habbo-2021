package onBoardingHcUi
{
    import flash.filters.DropShadowFilter;
    import flash.text.TextFormat;
    import flash.text.TextField;
    import flash.display.DisplayObject;
    import __AS3__.vec.Vector;
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.geom.Rectangle;
    import flash.geom.Point;
    import flash.geom.ColorTransform;
    import flash.display.Sprite;
    import flash.display.Shape;

    public class LoaderUI 
    {

        public static const STYLE_ILLUMINA:int = 1;
        public static const STYLE_HITCH:int = 2;
        public static const ANCHOR_LEFT:String = "l";
        public static const ANCHOR_CENTRE:String = "c";
        public static const ANCHOR_RIGHT:String = "r";
        public static const ANCHOR_TOP:String = "t";
        public static const ANCHOR_MIDDLE:String = "m";
        public static const ANCHOR_BOTTOM:String = "b";
        public static const HITCH_TEXT_BODY_COLOUR:uint = 8309486;
        public static const HITCH_TEXT_HIGHLIGHT_COLOUR:uint = 0xFFFFFF;

        private static const border_text_hitch_png:Class = HabboLoaderUI_border_text_hitch_png;
        public static var ubuntu_regular:Class = HabboLoaderUI_Habboubuntu_regular_ttf;
        public static var ubuntu_bold:Class = HabboLoaderUI_Habboubuntu_bold_ttf;
        public static var ubuntu_italic:Class = HabboLoaderUI_Habboubuntu_italic_ttf;
        public static var ubuntu_bold_italic:Class = HabboLoaderUI_Habboubuntu_bold_italic_ttf;
        private static const block_dark_point_down_png:Class = HabboLoaderUI_block_dark_point_down_png;
        private static const block_dark_point_up_png:Class = HabboLoaderUI_block_dark_point_up_png;
        private static const block_dark_point_left_png:Class = HabboLoaderUI_block_dark_point_left_png;
        private static const block_dark_point_right_png:Class = HabboLoaderUI_block_dark_point_right_png;
        private static const ETCHING_FILTER:DropShadowFilter = new DropShadowFilter(1, 90, 0xD1D400, 1, 1, 1);
        private static const NEGATIVE_ETCHING_FILTER:DropShadowFilter = new DropShadowFilter(1, 270, 0, 0.7, 1, 1);


        public static function createTextField(_arg_1:String, _arg_2:int, _arg_3:uint, _arg_4:Boolean=false, _arg_5:Boolean=false, _arg_6:Boolean=false, _arg_7:Boolean=false, _arg_8:String="left", _arg_9:Boolean=false, _arg_10:Boolean=false):TextField
        {
            var _local_11:TextFormat = new TextFormat("Ubuntu", _arg_2, _arg_3, _arg_4, _arg_7, _arg_10);
            _local_11.align = _arg_8;
            _local_11.kerning = _arg_9;
            var _local_12:LocalizedTextField = new LocalizedTextField();
            _local_12.embedFonts = true;
            _local_12.antiAliasType = "advanced";
            _local_12.defaultTextFormat = _local_11;
            _local_12.multiline = _arg_5;
            _local_12.wordWrap = _arg_5;
            _local_12.type = ((_arg_6) ? "input" : "dynamic");
            _local_12.selectable = _arg_6;
            _local_12.htmlText = _arg_1;
            _local_12.autoSize = "left";
            _local_12.width = _local_12.textWidth;
            _local_12.height = _local_12.textHeight;
            return (_local_12);
        }

        public static function addEtching(_arg_1:DisplayObject, _arg_2:Boolean=false):void
        {
            _arg_1.filters = [((_arg_2) ? NEGATIVE_ETCHING_FILTER.clone() : ETCHING_FILTER.clone())];
        }

        public static function lineUpHorizontally(_arg_1:DisplayObject, ... _args):void
        {
            var _local_5:int;
            var _local_3:int;
            var _local_6:DisplayObject;
            var _local_4:int = int((_args.length / 2));
            _local_5 = 0;
            while (_local_5 < _local_4)
            {
                _local_3 = _args[(_local_5 * 2)];
                _local_6 = _args[((_local_5 * 2) + 1)];
                _local_6.x = ((_arg_1.x + _arg_1.width) + _local_3);
                _arg_1 = _local_6;
                _local_5++;
            };
        }

        public static function lineUpHorizontallyRevers(_arg_1:DisplayObject, ... _args):void
        {
            var _local_5:int;
            var _local_3:int;
            var _local_6:DisplayObject;
            var _local_4:int = int((_args.length / 2));
            _local_5 = 0;
            while (_local_5 < _local_4)
            {
                _local_3 = _args[(_local_5 * 2)];
                _local_6 = _args[((_local_5 * 2) + 1)];
                _local_6.x = ((_arg_1.x - _local_3) - _local_6.width);
                _arg_1 = _local_6;
                _local_5++;
            };
        }

        public static function lineUpVerticallyRevers(_arg_1:DisplayObject, ... _args):void
        {
            var _local_5:int;
            var _local_3:int;
            var _local_6:DisplayObject;
            var _local_4:int = int((_args.length / 2));
            _local_5 = 0;
            while (_local_5 < _local_4)
            {
                _local_3 = _args[(_local_5 * 2)];
                _local_6 = _args[((_local_5 * 2) + 1)];
                _local_6.y = ((_arg_1.y - _local_3) - _local_6.height);
                _arg_1 = _local_6;
                _local_5++;
            };
        }

        public static function lineUpVertically(_arg_1:DisplayObject, ... _args):void
        {
            var _local_5:int;
            var _local_3:int;
            var _local_6:DisplayObject;
            var _local_4:int = int((_args.length / 2));
            _local_5 = 0;
            while (_local_5 < _local_4)
            {
                _local_3 = _args[(_local_5 * 2)];
                _local_6 = _args[((_local_5 * 2) + 1)];
                _local_6.y = ((_arg_1.y + _arg_1.height) + _local_3);
                _arg_1 = _local_6;
                _local_5++;
            };
        }

        public static function lineUpElementsVertically(_arg_1:Vector.<DisplayObject>, _arg_2:int):void
        {
            var _local_3:int;
            var _local_5:DisplayObject;
            if (((_arg_1 == null) || (_arg_1.length < 2)))
            {
                return;
            };
            var _local_4:DisplayObject = _arg_1[0];
            _local_3 = 0;
            while (_local_3 < (_arg_1.length - 1))
            {
                _local_5 = _arg_1[(_local_3 + 1)];
                _local_5.y = ((_local_4.y + _local_4.height) + _arg_2);
                _local_4 = _local_5;
                _local_3++;
            };
        }

        public static function alignAnchors(_arg_1:DisplayObject, _arg_2:int, _arg_3:String, ... _args):void
        {
            for each (var _local_5:DisplayObject in _args)
            {
                if (_arg_3.indexOf("l") >= 0)
                {
                    _local_5.x = (_arg_1.x + _arg_2);
                };
                if (_arg_3.indexOf("c") >= 0)
                {
                    _local_5.x = (_arg_1.x + int(((_arg_1.width - _local_5.width) / 2)));
                };
                if (_arg_3.indexOf("r") >= 0)
                {
                    _local_5.x = (((_arg_1.x + _arg_1.width) - _local_5.width) - _arg_2);
                };
                if (_arg_3.indexOf("t") >= 0)
                {
                    _local_5.y = (_arg_1.y + _arg_2);
                };
                if (_arg_3.indexOf("m") >= 0)
                {
                    _local_5.y = (_arg_1.y + int(((_arg_1.height - _local_5.height) / 2)));
                };
                if (_arg_3.indexOf("b") >= 0)
                {
                    _local_5.y = (((_arg_1.y + _arg_1.height) - _local_5.height) - _arg_2);
                };
            };
        }

        public static function createBalloon(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:Boolean, _arg_5:uint=0xFFFFFF, _arg_6:String="up"):Bitmap
        {
            var _local_9:Bitmap;
            var _local_10:int;
            var _local_11:int;
            var _local_8:Bitmap;
            if (_arg_3 < 0)
            {
                _arg_3 = int(((_arg_1 - 9) / 2));
            };
            var _local_7:NineSplitSprite = NineSplitSprite.DARK_BALLOON;
            switch (_arg_6)
            {
                case "up":
                    _local_9 = new block_dark_point_up_png();
                    _local_10 = _local_9.height;
                    _local_8 = new Bitmap(new BitmapData(_arg_1, (_arg_2 + _local_9.height), true, 860986));
                    _local_7.renderOn(_local_8, new Rectangle(0, _local_10, _arg_1, _arg_2));
                    _local_8.bitmapData.copyPixels(_local_9.bitmapData, _local_9.bitmapData.rect, new Point(_arg_3, 0));
                    break;
                case "down":
                    _local_9 = new block_dark_point_down_png();
                    _local_10 = _local_9.height;
                    _local_8 = new Bitmap(new BitmapData(_arg_1, (_arg_2 + _local_9.height), true, 860986));
                    _local_7.renderOn(_local_8, new Rectangle(0, _local_10, _arg_1, _arg_2));
                    _local_8.bitmapData.copyPixels(_local_9.bitmapData, _local_9.bitmapData.rect, new Point(_arg_3, (_arg_2 + _local_10)));
                    break;
                case "left":
                    _local_9 = new block_dark_point_left_png();
                    _local_11 = _local_9.width;
                    _local_8 = new Bitmap(new BitmapData((_arg_1 + _local_11), _arg_2, true, 0xFFFFFF));
                    _local_7.renderOn(_local_8, new Rectangle(_local_11, 0, _arg_1, _arg_2));
                    _local_8.bitmapData.copyPixels(_local_9.bitmapData, _local_9.bitmapData.rect, new Point(0, (_arg_3 - _local_11)));
                    break;
                case "right":
                    _local_9 = new block_dark_point_right_png();
                    _local_11 = _local_9.width;
                    _local_8 = new Bitmap(new BitmapData((_arg_1 + _local_11), _arg_2, true, 860986));
                    _local_7.renderOn(_local_8, new Rectangle(0, 0, _arg_1, _arg_2));
                    _local_8.bitmapData.copyPixels(_local_9.bitmapData, _local_9.bitmapData.rect, new Point(_arg_1, (_arg_3 - _local_11)));
                    break;
                case "none":
                    _local_8 = new Bitmap(new BitmapData(_arg_1, _arg_2, true, 860986));
                    _local_7.renderOn(_local_8, new Rectangle(0, 0, _arg_1, _arg_2));
            };
            _local_8.bitmapData.colorTransform(_local_8.bitmapData.rect, new ColorTransform((((_arg_5 >> 16) & 0xFF) / 0xFF), (((_arg_5 >> 8) & 0xFF) / 0xFF), ((_arg_5 & 0xFF) / 0xFF)));
            return (_local_8);
        }

        public static function createFrame(_arg_1:String, _arg_2:String, _arg_3:Rectangle, _arg_4:int=1):Sprite
        {
            var _local_8:TextField;
            var _local_9:Sprite = new Sprite();
            _local_9.x = _arg_3.x;
            _local_9.y = _arg_3.y;
            if (_arg_4 == 1)
            {
                _local_9.addChild(NineSplitSprite.FRAME.render(_arg_3.width, _arg_3.height));
            };
            var _local_5:uint = ((_arg_4 == 2) ? 8309486 : 0xFFFFFF);
            var _local_6:int = ((_arg_4 == 2) ? 24 : 40);
            var _local_7:TextField = createTextField(_arg_1, _local_6, _local_5, false, false, false, false);
            _local_7.y = -(_local_6 + 8);
            _local_7.autoSize = "left";
            _local_9.addChild(_local_7);
            if (_arg_4 == 2)
            {
                _local_7.width = _arg_3.width;
                _local_7.thickness = 50;
            };
            if (((!(_arg_2 == null)) && (!(_arg_2 == ""))))
            {
                _local_8 = createTextField(_arg_2, 10, 0xAAAAAA, true);
                _local_8.x = 8;
                _local_8.y = -(_local_6 + 16);
                _local_8.autoSize = "left";
                _local_9.addChild(_local_8);
            };
            return (_local_9);
        }

        public static function resizeFrame(_arg_1:Sprite, _arg_2:int, _arg_3:int):void
        {
            _arg_1.removeChildAt(0);
            _arg_1.addChildAt(NineSplitSprite.FRAME.render(_arg_2, _arg_3), 0);
        }

        public static function createScale9GridShapeFromImage(_arg_1:BitmapData, _arg_2:Rectangle):Shape
        {
            var _local_8:int;
            var _local_6:Number;
            var _local_9:int;
            var _local_3:Array = [(_arg_2.left - 0.001), (_arg_2.right + 0.001), _arg_1.width];
            var _local_4:Array = [(_arg_2.top - 0.001), (_arg_2.bottom + 0.001), _arg_1.height];
            var _local_5:Shape = new Shape();
            var _local_7:Number = 0;
            _local_8 = 0;
            while (_local_8 < 3)
            {
                _local_6 = 0;
                _local_9 = 0;
                while (_local_9 < 3)
                {
                    _local_5.graphics.beginBitmapFill(_arg_1);
                    _local_5.graphics.drawRect(_local_7, _local_6, (_local_3[_local_8] - _local_7), (_local_4[_local_9] - _local_6));
                    _local_5.graphics.endFill();
                    _local_6 = _local_4[_local_9];
                    _local_9++;
                };
                _local_7 = _local_3[_local_8];
                _local_8++;
            };
            _local_5.scale9Grid = _arg_2;
            return (_local_5);
        }

        public static function createTextBorder():Shape
        {
            return (createScale9GridShapeFromImage(Bitmap(new border_text_hitch_png()).bitmapData, new Rectangle(10, 10, 10, 10)));
        }


    }
}