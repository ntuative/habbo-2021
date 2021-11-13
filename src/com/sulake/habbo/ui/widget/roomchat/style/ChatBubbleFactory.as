package com.sulake.habbo.ui.widget.roomchat.style
{
    import com.sulake.core.utils.Map;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.window.components.IRegionWindow;
    import flash.display.BitmapData;
    import flash.geom.Point;
    import flash.geom.ColorTransform;
    import flash.geom.Matrix;
    import flash.geom.Rectangle;

    public class ChatBubbleFactory 
    {

        private static const _SafeStr_4237:int = 0;

        private var _styles:Map = new Map();

        public function ChatBubbleFactory(_arg_1:IAssetLibrary, _arg_2:IHabboWindowManager, _arg_3:XML)
        {
            super();
            var _local_4:int;
            var _local_5:String = null;
            var _local_7:String = null;
            var _local_6:XML = null;
            var _local_8:ChatBubbleStyle = null;
            for each (var _local_9:XML in _arg_3.child("style"))
            {
                _local_4 = _local_9.@id[0];
                _local_5 = _local_9.@assetId[0];
                _local_7 = (("roomchat_styles_" + _local_5) + "_style_xml");
                _local_6 = XML(_arg_1.getAssetByName(_local_7).content);
                try
                {
                    _local_8 = new ChatBubbleStyle(_arg_1, _arg_2, _local_6);
                    _styles.add(_local_4, _local_8);
                }
                catch(e:Error)
                {
                    Logger.log(((("Error initializing chat style: " + _local_4) + ", error message: ") + e.message));
                };
            };
        }

        public function getBubbleWindow(_arg_1:int, _arg_2:int):IRegionWindow
        {
            var _local_3:ChatBubbleStyle = getSafeChatBubbleStyle(_arg_1);
            switch (_arg_2)
            {
                case 0:
                    return (IRegionWindow(_local_3.normalLayout.clone()));
                case 2:
                    if (_local_3.shoutLayout != null)
                    {
                        return (IRegionWindow(_local_3.shoutLayout.clone()));
                    };
                    return (IRegionWindow(_local_3.normalLayout.clone()));
                case 1:
                    if (_local_3.whisperLayout != null)
                    {
                        return (IRegionWindow(_local_3.whisperLayout.clone()));
                    };
                    return (IRegionWindow(_local_3.normalLayout.clone()));
                default:
                    if (_local_3.whisperLayout != null)
                    {
                        return (IRegionWindow(_local_3.whisperLayout.clone()));
                    };
                    return (IRegionWindow(_local_3.normalLayout.clone()));
            };
        }

        public function getPointerBitmapData(_arg_1:int):BitmapData
        {
            return (getSafeChatBubbleStyle(_arg_1).pointerBitmapData);
        }

        public function buildBubbleImage(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:uint):BitmapData
        {
            var _local_14:ChatBubbleStyle;
            var _local_12:uint;
            var _local_9:int;
            var _local_10:int;
            _local_14 = getSafeChatBubbleStyle(_arg_1);
            var _local_16:int;
            var _local_11:Point = new Point();
            var _local_13:BitmapData = new BitmapData(((_local_14.leftBitmapData.width + _arg_3) + _local_14.rightBitmapData.width), _arg_4, true, 0);
            _local_16 = (_local_16 + _local_14.leftBitmapData.width);
            _local_13.copyPixels(_local_14.leftBitmapData, _local_14.leftBitmapData.rect, _local_11);
            if (_local_14.leftColorBitmapData != null)
            {
                _local_12 = 232;
                var _local_8:uint = 177;
                var _local_6:uint = 55;
                if (_arg_5 != 0)
                {
                    _local_12 = ((_arg_5 >> 16) & 0xFF);
                    _local_8 = ((_arg_5 >> 8) & 0xFF);
                    _local_6 = ((_arg_5 >> 0) & 0xFF);
                };
                _local_13.draw(_local_14.leftColorBitmapData, null, new ColorTransform((_local_12 / 0xFF), (_local_8 / 0xFF), (_local_6 / 0xFF)), "darken");
            };
            var _local_7:Matrix = new Matrix();
            if (_local_14.middleBitmapData.width == 1)
            {
                _local_7.scale((_arg_3 / _local_14.middleBitmapData.width), 1);
                _local_7.translate(_local_16, 0);
                _local_13.draw(_local_14.middleBitmapData, _local_7);
            }
            else
            {
                _local_7.translate(_local_16, 0);
                _local_9 = int(((_arg_3 / _local_14.middleBitmapData.width) + 1));
                _local_10 = 0;
                while (_local_10 < _local_9)
                {
                    _local_13.draw(_local_14.middleBitmapData, _local_7);
                    _local_7.translate(_local_14.middleBitmapData.width, 0);
                    _local_10++;
                };
            };
            _local_16 = (_local_16 + _arg_3);
            _local_11.x = _local_16;
            _local_13.copyPixels(_local_14.rightBitmapData, _local_14.rightBitmapData.rect, _local_11);
            var _local_15:Rectangle = _local_14.rightBitmapData.rect.clone();
            _local_15.offsetPoint(_local_11);
            return (_local_13);
        }

        public function getStyleIds():Array
        {
            return (_styles.getKeys());
        }

        public function getAllowedUserInputStyleIds():Array
        {
            var _local_3:ChatBubbleStyle;
            var _local_2:Array = [];
            for each (var _local_1:int in getStyleIds())
            {
                _local_3 = _styles.getValue(_local_1);
                if (((!(_local_3.isSystemStyle)) && (!(_local_3.isStaffOverrideable))))
                {
                    _local_2.push(_local_1);
                };
            };
            return (_local_2);
        }

        public function getStaffOverrideableStyleIds():Array
        {
            var _local_3:ChatBubbleStyle;
            var _local_2:Array = [];
            for each (var _local_1:int in getStyleIds())
            {
                _local_3 = _styles.getValue(_local_1);
                if (_local_3.isStaffOverrideable)
                {
                    _local_2.push(_local_1);
                };
            };
            return (_local_2);
        }

        public function getStyleSelectorPreviewBitmap(_arg_1:int):BitmapData
        {
            var _local_2:ChatBubbleStyle = getSafeChatBubbleStyle(_arg_1);
            return (_local_2.selectorPreviewIconBitmapData);
        }

        public function getActualBubbleHeight(_arg_1:int):int
        {
            var _local_2:ChatBubbleStyle = getSafeChatBubbleStyle(_arg_1);
            return (_local_2.middleBitmapData.height);
        }

        private function getSafeChatBubbleStyle(_arg_1:int):ChatBubbleStyle
        {
            if (!_styles.hasKey(_arg_1))
            {
                _arg_1 = 0;
            };
            return (ChatBubbleStyle(_styles.getValue(_arg_1)));
        }


    }
}

