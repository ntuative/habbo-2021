package com.sulake.habbo.communication.messages.parser.game.snowwar.data.event
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class HumanGetsSnowballsFromMachineEventData extends SnowWarGameEventData 
    {

        private var _humanGameObjectId:int;
        private var _snowBallMachineReference:int;

        public function HumanGetsSnowballsFromMachineEventData(_arg_1:int)
        {
            super(_arg_1);
        }

        public function get humanGameObjectId():int
        {
            return (_humanGameObjectId);
        }

        public function get snowBallMachineReference():int
        {
            return (_snowBallMachineReference);
        }

        override public function parse(_arg_1:IMessageDataWrapper):void
        {
            _humanGameObjectId = _arg_1.readInteger();
            _snowBallMachineReference = _arg_1.readInteger();
        }


    }
}