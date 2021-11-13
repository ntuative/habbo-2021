package com.sulake.habbo.communication.messages.parser.room.bots
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class BotSkillData 
    {

        private var _id:int;
        private var _data:String;

        public function BotSkillData(_arg_1:IMessageDataWrapper)
        {
            parse(_arg_1);
        }

        public function parse(_arg_1:IMessageDataWrapper):void
        {
            _id = _arg_1.readInteger();
            _data = _arg_1.readString();
        }

        public function get id():int
        {
            return (_id);
        }

        public function get data():String
        {
            return (_data);
        }


    }
}