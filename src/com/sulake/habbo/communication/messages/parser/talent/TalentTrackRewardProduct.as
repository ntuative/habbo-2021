package com.sulake.habbo.communication.messages.parser.talent
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class TalentTrackRewardProduct 
    {

        private var _productCode:String;
        private var _vipDays:int;

        public function TalentTrackRewardProduct(_arg_1:IMessageDataWrapper)
        {
            _productCode = _arg_1.readString();
            _vipDays = _arg_1.readInteger();
        }

        public function get productCode():String
        {
            return (_productCode);
        }

        public function get vipDays():int
        {
            return (_vipDays);
        }


    }
}