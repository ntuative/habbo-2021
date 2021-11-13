package com.sulake.habbo.communication.messages.parser.game.snowwar.data.object
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class SnowballGameObjectData extends SnowWarGameObjectData 
    {

        public static const _SafeStr_2012:int = 11;
        public static const TRAJECTORY_QUICK_THROW:int = 0;
        public static const TRAJECTORY_SHORT_LOB:int = 1;
        public static const TRAJECTORY_LONG_LOB:int = 2;

        public function SnowballGameObjectData(_arg_1:int, _arg_2:int)
        {
            super(_arg_1, _arg_2);
        }

        override public function parse(_arg_1:IMessageDataWrapper):void
        {
            parseVariables(_arg_1, 11);
        }

        public function get locationX3D():int
        {
            return (getVariable(2));
        }

        public function get locationY3D():int
        {
            return (getVariable(3));
        }

        public function get locationZ3D():int
        {
            return (getVariable(4));
        }

        public function get movementDirection360():int
        {
            return (getVariable(5));
        }

        public function get trajectory():int
        {
            return (getVariable(6));
        }

        public function get timeToLive():int
        {
            return (getVariable(7));
        }

        public function get throwingHuman():int
        {
            return (getVariable(8));
        }

        public function get parabolaOffset():int
        {
            return (getVariable(9));
        }

        public function get planarVelocity():int
        {
            return (getVariable(10));
        }


    }
}

