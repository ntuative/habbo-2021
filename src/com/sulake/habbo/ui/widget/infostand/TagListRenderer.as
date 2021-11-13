package com.sulake.habbo.ui.widget.infostand
{
    import flash.geom.Rectangle;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.assets.XmlAsset;

    public class TagListRenderer 
    {

        private const MARGIN_X:int = 5;
        private const MARGIN_Y:int = 5;

        private var _SafeStr_1324:InfoStandWidget;
        private var _SafeStr_447:Function;
        private var _offsetX:int;
        private var _offsetY:int;
        private var _SafeStr_1116:Rectangle = null;
        private var _SafeStr_1353:int = 0;
        private var _SafeStr_4174:Array;

        public function TagListRenderer(_arg_1:InfoStandWidget, _arg_2:Function)
        {
            _SafeStr_1324 = _arg_1;
            _SafeStr_447 = _arg_2;
        }

        public function dispose():void
        {
            _SafeStr_1324 = null;
            _SafeStr_447 = null;
        }

        public function renderTags(_arg_1:Array, _arg_2:IWindowContainer, _arg_3:Array):int
        {
            var _local_4:Array;
            var _local_5:String;
            var _local_9:ITextWindow;
            var _local_7:int;
            _SafeStr_4174 = _arg_3;
            if (_SafeStr_4174 != null)
            {
                _local_4 = [];
                while ((_local_5 = _arg_1.pop()) != null)
                {
                    ((_arg_3.indexOf(_local_5) != -1) ? _local_4.unshift(_local_5) : _local_4.push(_local_5));
                };
                _arg_1 = _local_4;
            };
            do 
            {
            } while (_arg_2.removeChildAt(0) != null);
            _SafeStr_1353 = 0;
            _offsetX = 0;
            _offsetY = 0;
            _SafeStr_1116 = _arg_2.rectangle;
            _SafeStr_1116.height = 150;
            _local_7 = 0;
            while (_local_7 < _arg_1.length)
            {
                _local_9 = createTag((_arg_1[_local_7] as String));
                if (fit(_local_9))
                {
                    _arg_2.addChild(_local_9);
                }
                else
                {
                    _local_9.dispose();
                };
                _local_7++;
            };
            var _local_8:int = _arg_2.numChildren;
            if (_local_8 == 0)
            {
                return (0);
            };
            var _local_6:IWindow = _arg_2.getChildAt((_arg_2.numChildren - 1));
            return (_local_6.bottom);
        }

        private function fit(_arg_1:IWindow):Boolean
        {
            if (_arg_1.width > _SafeStr_1116.width)
            {
                return (false);
            };
            if ((_offsetY + _arg_1.height) > _SafeStr_1116.height)
            {
                return (false);
            };
            if ((_offsetX + _arg_1.width) > _SafeStr_1116.width)
            {
                _offsetX = 0;
                _offsetY = (_offsetY + (_arg_1.height + 5));
                return (fit(_arg_1));
            };
            _arg_1.offset(_offsetX, _offsetY);
            _offsetX = (_offsetX + (_arg_1.width + 5));
            return (true);
        }

        private function createTag(_arg_1:String):ITextWindow
        {
            var _local_2:XmlAsset;
            if (((!(_SafeStr_4174 == null)) && (!(_SafeStr_4174.indexOf(_arg_1) == -1))))
            {
                _local_2 = (_SafeStr_1324.assets.getAssetByName("user_tag_highlighted") as XmlAsset);
            }
            else
            {
                _local_2 = (_SafeStr_1324.assets.getAssetByName("user_tag") as XmlAsset);
            };
            if (_local_2 == null)
            {
                return (null);
            };
            var _local_3:ITextWindow = (_SafeStr_1324.windowManager.buildFromXML((_local_2.content as XML)) as ITextWindow);
            if (_local_3 == null)
            {
                throw (new Error("Failed to construct window from XML!"));
            };
            _local_3.addEventListener("WME_CLICK", _SafeStr_447);
            _local_3.caption = _arg_1;
            return (_local_3);
        }


    }
}

