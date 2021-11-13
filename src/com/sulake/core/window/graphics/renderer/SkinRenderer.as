package com.sulake.core.window.graphics.renderer
{
    import flash.utils.Dictionary;
    import com.sulake.core.assets.IAsset;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.window.IWindow;
    import flash.display.BitmapData;
    import flash.geom.Rectangle;

    public class SkinRenderer implements ISkinRenderer 
    {

        protected static const ETCHING_POSITION:Dictionary = new Dictionary();

        private var _name:String;
        private var _disposed:Boolean = false;
        protected var _templatesByName:Dictionary;
        protected var _SafeStr_1108:Dictionary;
        protected var _layoutsByName:Dictionary;
        protected var _SafeStr_1109:Dictionary;

        {
            ETCHING_POSITION["top-left"] = {
                "x":-1,
                "y":-1
            };
            ETCHING_POSITION["top"] = {
                "x":0,
                "y":-1
            };
            ETCHING_POSITION["top-right"] = {
                "x":1,
                "y":-1
            };
            ETCHING_POSITION["left"] = {
                "x":-1,
                "y":0
            };
            ETCHING_POSITION["right"] = {
                "x":1,
                "y":0
            };
            ETCHING_POSITION["bottom-left"] = {
                "x":-1,
                "y":1
            };
            ETCHING_POSITION["bottom"] = {
                "x":0,
                "y":1
            };
            ETCHING_POSITION["bottom-right"] = {
                "x":1,
                "y":1
            };
        }

        public function SkinRenderer(_arg_1:String)
        {
            _name = _arg_1;
            _templatesByName = new Dictionary();
            _SafeStr_1108 = new Dictionary();
            _layoutsByName = new Dictionary();
            _SafeStr_1109 = new Dictionary();
        }

        public function get name():String
        {
            return (_name);
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function parse(_arg_1:IAsset, _arg_2:XMLList, _arg_3:IAssetLibrary):void
        {
        }

        public function dispose():void
        {
            var _local_1:String;
            if (!_disposed)
            {
                for (_local_1 in _layoutsByName)
                {
                    ISkinLayout(_layoutsByName[_local_1]).dispose();
                    delete _layoutsByName[_local_1];
                };
                _layoutsByName = null;
                _SafeStr_1109 = null;
                for (_local_1 in _templatesByName)
                {
                    ISkinTemplate(_templatesByName[_local_1]).dispose();
                    delete _templatesByName[_local_1];
                };
                _templatesByName = null;
                _SafeStr_1108 = null;
            };
        }

        public function draw(_arg_1:IWindow, _arg_2:BitmapData, _arg_3:Rectangle, _arg_4:uint, _arg_5:Boolean):void
        {
        }

        public function isStateDrawable(_arg_1:uint):Boolean
        {
            return (false);
        }

        public function getLayoutByState(_arg_1:uint):ISkinLayout
        {
            return (_SafeStr_1109[_arg_1]);
        }

        public function registerLayoutForRenderState(_arg_1:uint, _arg_2:String):void
        {
            var _local_3:ISkinLayout = _layoutsByName[_arg_2];
            if (_local_3 == null)
            {
                throw (new Error((('Layout "' + _arg_2) + '" not found in renderer!')));
            };
            _SafeStr_1109[_arg_1] = _local_3;
        }

        public function removeLayoutFromRenderState(_arg_1:uint):void
        {
            delete _SafeStr_1109[_arg_1]; //not popped
        }

        public function hasLayoutForState(_arg_1:uint):Boolean
        {
            return (!(_SafeStr_1109[_arg_1] == null));
        }

        public function getTemplateByState(_arg_1:uint):ISkinTemplate
        {
            return (_SafeStr_1108[_arg_1]);
        }

        public function registerTemplateForRenderState(_arg_1:uint, _arg_2:String):void
        {
            var _local_3:ISkinTemplate = _templatesByName[_arg_2];
            if (_local_3 == null)
            {
                throw (new Error((('Template "' + _arg_2) + '" not found in renderer!')));
            };
            _SafeStr_1108[_arg_1] = _local_3;
        }

        public function removeTemplateFromRenderState(_arg_1:uint):void
        {
            delete _SafeStr_1108[_arg_1]; //not popped
        }

        public function hasTemplateForState(_arg_1:uint):Boolean
        {
            return (!(_SafeStr_1108[_arg_1] == null));
        }

        public function addLayout(_arg_1:ISkinLayout):ISkinLayout
        {
            _layoutsByName[_arg_1.name] = _arg_1;
            return (_arg_1);
        }

        public function getLayoutByName(_arg_1:String):ISkinLayout
        {
            return (_layoutsByName[_arg_1]);
        }

        public function removeLayout(_arg_1:ISkinLayout):ISkinLayout
        {
            var _local_2:uint;
            var _local_3:Object;
            _arg_1 = _templatesByName[_arg_1.name];
            if (_arg_1 != null)
            {
                for (_local_3 in _SafeStr_1109)
                {
                    _local_2 = (_local_3 as uint);
                    if (_SafeStr_1109[_local_2] == _arg_1)
                    {
                        removeLayoutFromRenderState(_local_2);
                    };
                };
                delete _layoutsByName[_arg_1.name];
            };
            return (_arg_1);
        }

        public function addTemplate(_arg_1:ISkinTemplate):ISkinTemplate
        {
            _templatesByName[_arg_1.name] = _arg_1;
            return (_arg_1);
        }

        public function getTemplateByName(_arg_1:String):ISkinTemplate
        {
            return (_templatesByName[_arg_1]);
        }

        public function removeTemplate(_arg_1:ISkinTemplate):ISkinTemplate
        {
            var _local_2:uint;
            var _local_3:Object;
            _arg_1 = _templatesByName[_arg_1.name];
            if (_arg_1 != null)
            {
                for (_local_3 in _SafeStr_1108)
                {
                    _local_2 = (_local_3 as uint);
                    if (_SafeStr_1108[_local_2] == _arg_1)
                    {
                        removeTemplateFromRenderState(_local_2);
                    };
                };
                delete _templatesByName[_arg_1.name];
            };
            return (_arg_1);
        }


    }
}

