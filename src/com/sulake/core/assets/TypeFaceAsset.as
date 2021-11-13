package com.sulake.core.assets
{
    import flash.text.Font;
    import com.sulake.core.utils.FontEnum;

    public class TypeFaceAsset implements IAsset 
    {

        protected var _SafeStr_802:AssetTypeDeclaration;
        protected var _content:Font;
        protected var _disposed:Boolean = false;

        public function TypeFaceAsset(_arg_1:AssetTypeDeclaration, _arg_2:String=null)
        {
            _SafeStr_802 = _arg_1;
        }

        public function get url():String
        {
            return (null);
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
            return (_SafeStr_802);
        }

        public function dispose():void
        {
            if (!_disposed)
            {
                _SafeStr_802 = null;
                _content = null;
                _disposed = true;
            };
        }

        public function setUnknownContent(_arg_1:Object):void
        {
            try
            {
                if ((_arg_1 is Class))
                {
                    _content = Font(FontEnum.registerFont((_arg_1 as Class)));
                };
            }
            catch(e:Error)
            {
                throw (new Error(("Failed to register font from resource: " + _arg_1)));
            };
        }

        public function setFromOtherAsset(_arg_1:IAsset):void
        {
            if ((_arg_1 is TypeFaceAsset))
            {
                _content = TypeFaceAsset(_arg_1)._content;
            }
            else
            {
                throw (new Error("Provided asset should be of type FontAsset!"));
            };
        }

        public function setParamsDesc(_arg_1:XMLList):void
        {
        }


    }
}

