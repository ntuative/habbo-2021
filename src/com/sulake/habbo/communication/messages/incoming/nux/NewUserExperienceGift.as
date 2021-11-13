package com.sulake.habbo.communication.messages.incoming.nux
{
    import __AS3__.vec.Vector;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class NewUserExperienceGift 
    {

        private var _productOfferList:Vector.<NewUserExperienceGiftProduct>;
        private var _thumbnailUrl:String;

        public function NewUserExperienceGift(_arg_1:IMessageDataWrapper)
        {
            var _local_3:int;
            super();
            _thumbnailUrl = _arg_1.readString();
            if (_thumbnailUrl == "")
            {
                _thumbnailUrl = null;
            };
            _productOfferList = new Vector.<NewUserExperienceGiftProduct>();
            var _local_2:int = _arg_1.readInteger();
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                _productOfferList.push(new NewUserExperienceGiftProduct(_arg_1));
                _local_3++;
            };
        }

        public function get productOfferList():Vector.<NewUserExperienceGiftProduct>
        {
            return (_productOfferList);
        }

        public function get thumbnailUrl():String
        {
            return (_thumbnailUrl);
        }


    }
}