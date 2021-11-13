package com.sulake.habbo.ui.widget.roomchat.style
{
    import com.sulake.core.window.components.IRegionWindow;
    import flash.display.BitmapData;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAsset;

    public class ChatBubbleStyle 
    {

        private var _SafeStr_1921:int;
        private var _styleName:String;
        private var _isSystemStyle:Boolean = false;
        private var _isStaffOverrideable:Boolean = false;
        private var _normalLayout:IRegionWindow;
        private var _whisperLayout:IRegionWindow;
        private var _shoutLayout:IRegionWindow;
        private var _leftBitmapData:BitmapData;
        private var _leftColorBitmapData:BitmapData;
        private var _middleBitmapData:BitmapData;
        private var _rightBitmapData:BitmapData;
        private var _pointerBitmapData:BitmapData;
        private var _selectorPreviewIconBitmapData:BitmapData;

        public function ChatBubbleStyle(_arg_1:IAssetLibrary, _arg_2:IHabboWindowManager, _arg_3:XML)
        {
            _SafeStr_1921 = _arg_3.@id[0];
            _styleName = _arg_3.@name[0];
            _isSystemStyle = _arg_3.@systemstyle[0];
            _isStaffOverrideable = _arg_3.@staffoverride[0];
            var _local_11:XML = _arg_3.child("layouts")[0];
            var _local_4:XML = _arg_3.child("bitmaps")[0];
            _normalLayout = buildBubbleWindow(_arg_2, _arg_1, getXmlElementAssetId(_local_11, "speakLayout"));
            _whisperLayout = buildBubbleWindow(_arg_2, _arg_1, getXmlElementAssetId(_local_11, "whisperLayout"));
            _shoutLayout = buildBubbleWindow(_arg_2, _arg_1, getXmlElementAssetId(_local_11, "shoutLayout"));
            var _local_9:String = getXmlElementAssetId(_local_4, "leftBitmap");
            var _local_6:String = getXmlElementAssetId(_local_4, "leftColorBitmap");
            var _local_7:String = getXmlElementAssetId(_local_4, "middleBitmap");
            var _local_5:String = getXmlElementAssetId(_local_4, "rightBitmap");
            var _local_10:String = getXmlElementAssetId(_local_4, "pointerBitmap");
            if (_local_9)
            {
                _leftBitmapData = getBitmapDataFor(_local_9, _arg_1);
            };
            if (_local_6)
            {
                _leftColorBitmapData = getBitmapDataFor(_local_6, _arg_1);
            };
            if (_local_7)
            {
                _middleBitmapData = getBitmapDataFor(_local_7, _arg_1);
            };
            if (_local_5)
            {
                _rightBitmapData = getBitmapDataFor(_local_5, _arg_1);
            };
            if (_local_10)
            {
                _pointerBitmapData = getBitmapDataFor(_local_10, _arg_1);
            };
            var _local_8:String = getXmlElementAssetId(_local_4, "previewIconBitmap");
            if (_local_8)
            {
                _selectorPreviewIconBitmapData = getBitmapDataFor(_local_8, _arg_1);
            };
        }

        private static function getXmlElementAssetId(_arg_1:XML, _arg_2:String):String
        {
            var _local_3:XMLList = _arg_1.child(_arg_2);
            if (_local_3.length() < 1)
            {
                return (null);
            };
            var _local_4:XMLList = XML(_local_3[0]).attribute("assetId");
            if (_local_4.length() < 1)
            {
                return (null);
            };
            return (_local_4[0]);
        }


        public function get normalLayout():IRegionWindow
        {
            return (_normalLayout);
        }

        public function get whisperLayout():IRegionWindow
        {
            return (_whisperLayout);
        }

        public function get shoutLayout():IRegionWindow
        {
            return (_shoutLayout);
        }

        public function get leftBitmapData():BitmapData
        {
            return (_leftBitmapData);
        }

        public function get leftColorBitmapData():BitmapData
        {
            return (_leftColorBitmapData);
        }

        public function get middleBitmapData():BitmapData
        {
            return (_middleBitmapData);
        }

        public function get rightBitmapData():BitmapData
        {
            return (_rightBitmapData);
        }

        public function get pointerBitmapData():BitmapData
        {
            return (_pointerBitmapData);
        }

        public function get isSystemStyle():Boolean
        {
            return (_isSystemStyle);
        }

        public function get isStaffOverrideable():Boolean
        {
            return (_isStaffOverrideable);
        }

        public function get selectorPreviewIconBitmapData():BitmapData
        {
            return (_selectorPreviewIconBitmapData);
        }

        private function buildBubbleWindow(_arg_1:IHabboWindowManager, _arg_2:IAssetLibrary, _arg_3:String):IRegionWindow
        {
            if (_arg_3 == null)
            {
                return (null);
            };
            var _local_5:IAsset = _arg_2.getAssetByName(localAssetName((_arg_3 + "_xml")));
            var _local_4:IRegionWindow = (_arg_1.buildFromXML((_local_5.content as XML), 1) as IRegionWindow);
            _local_4.tags.push("roomchat_bubble");
            _local_4.x = 0;
            _local_4.y = 0;
            _local_4.width = 0;
            _local_4.background = true;
            _local_4.mouseThreshold = 0;
            _local_4.setParamFlag(0x40000000, true);
            return (_local_4);
        }

        private function localAssetName(_arg_1:String):String
        {
            return ((("roomchat_styles_" + _styleName) + "_") + _arg_1);
        }

        private function getBitmapDataFor(_arg_1:String, _arg_2:IAssetLibrary):BitmapData
        {
            var _local_3:IAsset = _arg_2.getAssetByName(localAssetName(_arg_1));
            if (_local_3)
            {
                return (BitmapData(_local_3.content));
            };
            throw (new Error(("Configured bitmapdata asset missing for chat bubble style: " + localAssetName(_arg_1))));
        }


    }
}

