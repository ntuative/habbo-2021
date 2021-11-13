package com.sulake.core.assets
{
    import flash.utils.ByteArray;

    public class TextAsset implements IAsset 
    {

        private var _disposed:Boolean = false;
        private var _content:String = "";
        private var _declaration:AssetTypeDeclaration;
        private var _url:String;

        public function TextAsset(_arg_1:AssetTypeDeclaration, _arg_2:String=null)
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
            var _local_2:ByteArray;
            if ((_arg_1 is String))
            {
                _content = (_arg_1 as String);
                return;
            };
            if ((_arg_1 is Class))
            {
                var _local_2_cls:Class = _arg_1 as Class;
                _local_2 = new _local_2_cls() as ByteArray;
                _content = _local_2.readUTFBytes(_local_2.length);
                return;
            };
            if ((_arg_1 is ByteArray))
            {
                _local_2 = (_arg_1 as ByteArray);
                _content = _local_2.readUTFBytes(_local_2.length);
                return;
            };
            if ((_arg_1 is TextAsset))
            {
                _content = TextAsset(_arg_1)._content;
                return;
            };
            _content = ((_arg_1) ? _arg_1.toString() : "");
        }

        public function setFromOtherAsset(_arg_1:IAsset):void
        {
            if ((_arg_1 is TextAsset))
            {
                _content = TextAsset(_arg_1)._content;
            }
            else
            {
                throw (Error("Provided asset is not of type TextAsset!"));
            };
        }

        public function setParamsDesc(_arg_1:XMLList):void
        {
        }


    }
}