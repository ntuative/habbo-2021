package com.sulake.habbo.communication.messages.incoming.landingview
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class PromoArticleData 
    {

        public static const _SafeStr_1790:int = 0;
        public static const _SafeStr_1791:int = 1;
        public static const _SafeStr_1792:int = 2;

        private var _id:int;
        private var _title:String;
        private var _bodyText:String;
        private var _buttonText:String;
        private var _linkType:int;
        private var _linkContent:String;
        private var _imageUrl:String;

        public function PromoArticleData(_arg_1:IMessageDataWrapper)
        {
            _id = _arg_1.readInteger();
            _title = _arg_1.readString();
            _bodyText = _arg_1.readString();
            _buttonText = _arg_1.readString();
            _linkType = _arg_1.readInteger();
            _linkContent = _arg_1.readString();
            _imageUrl = _arg_1.readString();
        }

        public function get id():int
        {
            return (_id);
        }

        public function get title():String
        {
            return (_title);
        }

        public function get bodyText():String
        {
            return (_bodyText);
        }

        public function get buttonText():String
        {
            return (_buttonText);
        }

        public function get linkType():int
        {
            return (_linkType);
        }

        public function get linkContent():String
        {
            return (_linkContent);
        }

        public function get imageUrl():String
        {
            return (_imageUrl);
        }


    }
}

