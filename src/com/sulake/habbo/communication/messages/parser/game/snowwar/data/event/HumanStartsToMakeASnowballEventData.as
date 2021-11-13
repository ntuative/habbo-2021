package com.sulake.habbo.communication.messages.parser.game.snowwar.data.event
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class HumanStartsToMakeASnowballEventData extends SnowWarGameEventData 
    {

        private var _humanGameObjectId:int;

        public function HumanStartsToMakeASnowballEventData(_arg_1:int)
        {
            super(_arg_1);
        }

        public function get humanGameObjectId():int
        {
            return (_humanGameObjectId);
        }

        override public function parse(_arg_1:IMessageDataWrapper):void
        {
            _humanGameObjectId = _arg_1.readInteger();
        }


    }
}