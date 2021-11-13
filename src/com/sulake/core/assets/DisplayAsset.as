package com.sulake.core.assets
{
    import flash.display.DisplayObject;

    public class DisplayAsset implements IAsset 
    {

        protected var _SafeStr_780:String;
        protected var _content:DisplayObject;
        protected var _disposed:Boolean = false;
        protected var _declaration:AssetTypeDeclaration;

        public function DisplayAsset(_arg_1:AssetTypeDeclaration, _arg_2:String=null)
        {
            _declaration = _arg_1;
            _SafeStr_780 = _arg_2;
        }

        public function get url():String
        {
            return (_SafeStr_780);
        }

        public function get content():Object
        {
            return (_content);
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function get declaration():AssetTypeDeclaration
        {
            return (_declaration);
        }

        public function dispose():void
        {
            if (!_disposed)
            {
                if (_content.loaderInfo != null)
                {
                    if (_content.loaderInfo.loader != null)
                    {
                        _content.loaderInfo.loader.unload();
                    };
                };
                _content = null;
                _declaration = null;
                _disposed = true;
                _SafeStr_780 = null;
            };
        }

        public function setUnknownContent(_arg_1:Object):void
        {
            if ((_arg_1 is DisplayObject))
            {
                _content = (_arg_1 as DisplayObject);
                if (_content != null)
                {
                    return;
                };
                throw (new Error("Failed to convert DisplayObject to DisplayAsset!"));
            };
            if ((_arg_1 is DisplayAsset))
            {
                _content = DisplayAsset(_arg_1)._content;
                _declaration = DisplayAsset(_arg_1)._declaration;
                if (_content == null)
                {
                    throw (new Error("Failed to read content from DisplayAsset!"));
                };
            };
        }

        public function setFromOtherAsset(_arg_1:IAsset):void
        {
            if ((_arg_1 is DisplayAsset))
            {
                _content = DisplayAsset(_arg_1)._content;
                _declaration = DisplayAsset(_arg_1)._declaration;
            }
            else
            {
                throw (new Error("Provided asset should be of type DisplayAsset!"));
            };
        }

        public function setParamsDesc(_arg_1:XMLList):void
        {
        }


    }
}

