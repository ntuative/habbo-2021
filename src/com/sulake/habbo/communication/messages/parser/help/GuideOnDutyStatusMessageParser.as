package com.sulake.habbo.communication.messages.parser.help
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class GuideOnDutyStatusMessageParser implements IMessageParser 
    {

        private var _onDuty:Boolean;
        private var _guidesOnDuty:int;
        private var _helpersOnDuty:int;
        private var _guardiansOnDuty:int;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _onDuty = _arg_1.readBoolean();
            _guidesOnDuty = _arg_1.readInteger();
            _helpersOnDuty = _arg_1.readInteger();
            _guardiansOnDuty = _arg_1.readInteger();
            return (true);
        }

        public function get onDuty():Boolean
        {
            return (_onDuty);
        }

        public function get helpersOnDuty():int
        {
            return (_helpersOnDuty);
        }

        public function get guardiansOnDuty():int
        {
            return (_guardiansOnDuty);
        }

        public function get guidesOnDuty():int
        {
            return (_guidesOnDuty);
        }


    }
}