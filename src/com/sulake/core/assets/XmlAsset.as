package com.sulake.core.assets
{
    import flash.utils.ByteArray;

    public class XmlAsset implements ILazyAsset 
    {

        private var _disposed:Boolean = false;
        private var _SafeStr_798:Object;
        private var _content:XML;
        private var _declaration:AssetTypeDeclaration;
        private var _url:String;

        public function XmlAsset(_arg_1:AssetTypeDeclaration, _arg_2:String=null)
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
            if (!_content)
            {
                prepareLazyContent();
            };
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
                _SafeStr_798 = null;
                _declaration = null;
                _url = null;
            };
        }

        public function setUnknownContent(_arg_1:Object):void
        {
            _content = null;
            _SafeStr_798 = _arg_1;
        }

        public function prepareLazyContent():void
        {
            var _local_1:ByteArray;
            if ((_SafeStr_798 is Class))
            {
                var _local_1_cls:Class = _SafeStr_798 as Class;
                _local_1 = new _local_1_cls() as ByteArray;
                _content = new XML(_local_1.readUTFBytes(_local_1.length));
                return;
            };
            if ((_SafeStr_798 is ByteArray))
            {
                _local_1 = (_SafeStr_798 as ByteArray);
                _content = new XML(_local_1.readUTFBytes(_local_1.length));
                return;
            };
            if ((_SafeStr_798 is String))
            {
                _content = new XML((_SafeStr_798 as String));
                return;
            };
            if ((_SafeStr_798 is XML))
            {
                _content = (_SafeStr_798 as XML);
                return;
            };
            if ((_SafeStr_798 is XmlAsset))
            {
                _content = XmlAsset(_SafeStr_798)._content;
                return;
            };
        }

        public function setFromOtherAsset(_arg_1:IAsset):void
        {
            if ((_arg_1 is XmlAsset))
            {
                _content = XmlAsset(_arg_1)._content;
            }
            else
            {
                throw (Error("Provided asset is not of type XmlAsset!"));
            };
        }

        public function setParamsDesc(_arg_1:XMLList):void
        {
        }

        public function toString():String
        {
            var _local_1:String = "XmlAsset";
            _local_1 = (_local_1 + (" _url:" + _url));
            _local_1 = (_local_1 + (" _content:" + _content));
            return (_local_1 + (" _unknown:" + _SafeStr_798));
        }


    }
}

