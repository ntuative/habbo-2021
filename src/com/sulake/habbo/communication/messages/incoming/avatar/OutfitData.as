package com.sulake.habbo.communication.messages.incoming.avatar
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class OutfitData 
    {

        private var _slotId:int;
        private var _figureString:String;
        private var _gender:String;

        public function OutfitData(_arg_1:IMessageDataWrapper)
        {
            _slotId = _arg_1.readInteger();
            _figureString = _arg_1.readString();
            _gender = _arg_1.readString();
        }

        public function get slotId():int
        {
            return (_slotId);
        }

        public function get figureString():String
        {
            return (_figureString);
        }

        public function get gender():String
        {
            return (_gender);
        }


    }
}