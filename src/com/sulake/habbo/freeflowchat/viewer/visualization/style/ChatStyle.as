package com.sulake.habbo.freeflowchat.viewer.visualization.style
{
    import com.sulake.habbo.freeflowchat.style.IChatStyle;
    import flash.display.BitmapData;
    import flash.geom.Rectangle;
    import flash.text.TextFormat;
    import flash.geom.Point;
    import flash.text.StyleSheet;
    import flash.geom.ColorTransform;
    import com.sulake.habbo.freeflowchat.HabboFreeFlowChat;
    import flash.display.Sprite;

    public class ChatStyle implements IChatStyle, IChatStyleInternal 
    {

        private var _background:BitmapData;
        private var _scale9Grid:Rectangle;
        private var _pointer:BitmapData;
        private var _pointerY:int;
        private var _textFieldMargins:Rectangle;
        private var _textFormat:TextFormat;
        private var _iconImage:BitmapData;
        private var _faceOffset:Point;
        private var _selectorPreview:BitmapData;
        private var _color:BitmapData;
        private var _colorOffset:Point;
        private var _overlap:Rectangle;
        private var _isSystemStyle:Boolean;
        private var _isHcOnly:Boolean;
        private var _isAmbassadorOnly:Boolean;
        private var _isStaffOverrideable:Boolean;
        private var _isAnonymous:Boolean;
        private var _allowHTML:Boolean;
        private var _styleSheet:StyleSheet;

        public function ChatStyle(_arg_1:BitmapData, _arg_2:Rectangle, _arg_3:BitmapData, _arg_4:int, _arg_5:Rectangle, _arg_6:TextFormat, _arg_7:Boolean, _arg_8:Point, _arg_9:BitmapData, _arg_10:BitmapData, _arg_11:Boolean, _arg_12:Boolean, _arg_13:Boolean, _arg_14:Boolean, _arg_15:BitmapData=null, _arg_16:Point=null, _arg_17:Rectangle=null, _arg_18:Boolean=false, _arg_19:StyleSheet=null)
        {
            _background = _arg_1;
            _scale9Grid = _arg_2;
            _pointer = _arg_3;
            _pointerY = _arg_4;
            _textFieldMargins = _arg_5;
            _textFormat = _arg_6;
            _isAnonymous = _arg_7;
            _faceOffset = _arg_8;
            _iconImage = _arg_9;
            _selectorPreview = _arg_10;
            _isSystemStyle = _arg_11;
            _isHcOnly = _arg_12;
            _isAmbassadorOnly = _arg_14;
            _isStaffOverrideable = _arg_13;
            _color = _arg_15;
            _colorOffset = _arg_16;
            _overlap = _arg_17;
            _allowHTML = _arg_18;
            _styleSheet = _arg_19;
        }

        public function getNewBackgroundSprite(_arg_1:uint=0xFFFFFF):Sprite
        {
            var _local_4:BitmapData;
            var _local_2:uint;
            var _local_5:uint;
            var _local_3:uint;
            if (_color != null)
            {
                _local_4 = new BitmapData(_background.width, _background.height, _background.transparent, 0);
                _local_4.copyPixels(_background, _background.rect, new Point(0, 0));
                _local_2 = ((_arg_1 >> 16) & 0xFF);
                _local_5 = ((_arg_1 >> 8) & 0xFF);
                _local_3 = ((_arg_1 >> 0) & 0xFF);
                _local_4.draw(_color, null, new ColorTransform((_local_2 / 0xFF), (_local_5 / 0xFF), (_local_3 / 0xFF)), "darken");
            }
            else
            {
                _local_4 = _background;
            };
            return (HabboFreeFlowChat.create9SliceSprite(_scale9Grid, _local_4));
        }

        public function get textFormat():TextFormat
        {
            return (_textFormat);
        }

        public function get styleSheet():StyleSheet
        {
            return (_styleSheet);
        }

        public function get pointer():BitmapData
        {
            return (_pointer);
        }

        public function get pointerOffsetToBubbleBottom():int
        {
            return (_background.height - _pointerY);
        }

        public function get isAnonymous():Boolean
        {
            return (_isAnonymous);
        }

        public function get faceOffset():Point
        {
            return (_faceOffset);
        }

        public function get iconImage():BitmapData
        {
            return (_iconImage);
        }

        public function get textFieldMargins():Rectangle
        {
            return (_textFieldMargins);
        }

        public function get overlap():Rectangle
        {
            return (_overlap);
        }

        public function get selectorPreview():BitmapData
        {
            return (_selectorPreview);
        }

        public function get isSystemStyle():Boolean
        {
            return (_isSystemStyle);
        }

        public function get isHcOnly():Boolean
        {
            return (_isHcOnly);
        }

        public function get isAmbassadorOnly():Boolean
        {
            return (_isAmbassadorOnly);
        }

        public function get isStaffOverrideable():Boolean
        {
            return (_isStaffOverrideable);
        }

        public function get allowHTML():Boolean
        {
            return (_allowHTML);
        }


    }
}