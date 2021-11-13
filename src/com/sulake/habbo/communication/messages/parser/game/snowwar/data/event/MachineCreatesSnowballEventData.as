package com.sulake.habbo.communication.messages.parser.game.snowwar.data.event
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class MachineCreatesSnowballEventData extends SnowWarGameEventData 
    {

        private var _snowBallMachineReference:int;

        public function MachineCreatesSnowballEventData(_arg_1:int)
        {
            super(_arg_1);
        }

        public function get snowBallMachineReference():int
        {
            return (_snowBallMachineReference);
        }

        override public function parse(_arg_1:IMessageDataWrapper):void
        {
            _snowBallMachineReference = _arg_1.readInteger();
        }


    }
}