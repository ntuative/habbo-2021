package com.sulake.habbo.communication.messages.incoming.nux
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class NewUserExperienceGiftProduct 
    {

        private var _productCode:String;
        private var _localizationKey:String;

        public function NewUserExperienceGiftProduct(_arg_1:IMessageDataWrapper)
        {
            _productCode = _arg_1.readString();
            _localizationKey = _arg_1.readString();
            if (_localizationKey == "")
            {
                _localizationKey = null;
            };
        }

        public function get productCode():String
        {
            return (_productCode);
        }

        public function get localizationKey():String
        {
            return (_localizationKey);
        }


    }
}