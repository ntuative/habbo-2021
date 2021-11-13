package com.sulake.habbo.communication.messages.parser.game.snowwar.data.event
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class SnowWarGameEventData 
    {

        public static const _SafeStr_2004:int = 1;
        public static const _SafeStr_2005:int = 2;
        public static const _SafeStr_2006:int = 3;
        public static const _SafeStr_2007:int = 4;
        public static const _SafeStr_2008:int = 7;
        public static const _SafeStr_2009:int = 8;
        public static const _SafeStr_2010:int = 11;
        public static const _SafeStr_2011:int = 12;

        private var _id:int;

        public function SnowWarGameEventData(_arg_1:int)
        {
            _id = _arg_1;
        }

        public static function create(_arg_1:int):SnowWarGameEventData
        {
            switch (_arg_1)
            {
                case 2:
                    return (new NewMoveTargetEventData(_arg_1));
                case 3:
                    return (new HumanThrowsSnowballAtHumanEventData(_arg_1));
                case 4:
                    return (new HumanThrowsSnowballAtPositionEventData(_arg_1));
                case 7:
                    return (new HumanStartsToMakeASnowballEventData(_arg_1));
                case 8:
                    return (new CreateSnowballEventData(_arg_1));
                case 11:
                    return (new MachineCreatesSnowballEventData(_arg_1));
                case 12:
                    return (new HumanGetsSnowballsFromMachineEventData(_arg_1));
                case 1:
                    return (new HumanLeftGameEventData(_arg_1));
                default:
                    return (null);
            };
        }


        public function get id():int
        {
            return (_id);
        }

        public function set id(_arg_1:int):void
        {
            _id = _arg_1;
        }

        public function parse(_arg_1:IMessageDataWrapper):void
        {
        }


    }
}

