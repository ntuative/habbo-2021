package com.sulake.core.assets
{
    import flash.media.Sound;
    import flash.utils.ByteArray;

    public class SoundAsset implements IAsset 
    {

        private var _disposed:Boolean = false;
        private var _content:Sound = null;
        private var _declaration:AssetTypeDeclaration;
        private var _url:String;

        public function SoundAsset(_arg_1:AssetTypeDeclaration, _arg_2:String=null)
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
            return (_content as Object);
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
            if ((_arg_1 is Sound))
            {
                if (_content)
                {
                    _content.close();
                };
                _content = (_arg_1 as Sound);
                return;
            };
            if ((_arg_1 is ByteArray))
            {
            };
            if ((_arg_1 is Class))
            {
                if (_content)
                {
                    _content.close();
                };
                var _content_cls:Class = _arg_1 as Class;
                _content = new _content_cls() as Sound;
                return;
            };
            if ((_arg_1 is SoundAsset))
            {
                if (_content)
                {
                    _content.close();
                };
                _content = SoundAsset(_arg_1)._content;
                return;
            };
        }

        public function setFromOtherAsset(_arg_1:IAsset):void
        {
            if ((_arg_1 is SoundAsset))
            {
                _content = SoundAsset(_arg_1)._content;
            };
        }

        public function setParamsDesc(_arg_1:XMLList):void
        {
        }


    }
}