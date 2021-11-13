package com.sulake.core.assets
{
    import flash.utils.getQualifiedClassName;

    public class UnknownAsset implements IAsset 
    {

        private var _disposed:Boolean = false;
        private var _content:Object = null;
        private var _declaration:AssetTypeDeclaration;
        private var _url:String;

        public function UnknownAsset(_arg_1:AssetTypeDeclaration, _arg_2:String=null)
        {
            _declaration = _arg_1;
            _url = _arg_2;
        }

        public function get url():String
        {
            return (_url);
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
                _disposed = true;
                _content = null;
                _declaration = null;
                _url = null;
            };
        }

        public function setUnknownContent(_arg_1:Object):void
        {
            _content = _arg_1;
        }

        public function setFromOtherAsset(_arg_1:IAsset):void
        {
            _content = (_arg_1.content as Object);
        }

        public function setParamsDesc(_arg_1:XMLList):void
        {
        }

        public function toString():String
        {
            return ((getQualifiedClassName(this) + ": ") + _content);
        }


    }
}