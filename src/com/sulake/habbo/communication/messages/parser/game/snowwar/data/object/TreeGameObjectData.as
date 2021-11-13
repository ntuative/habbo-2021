package com.sulake.habbo.communication.messages.parser.game.snowwar.data.object
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class TreeGameObjectData extends SnowWarGameObjectData 
    {

        public static const _SafeStr_2012:int = 9;

        public function TreeGameObjectData(_arg_1:int, _arg_2:int)
        {
            super(_arg_1, _arg_2);
        }

        override public function parse(_arg_1:IMessageDataWrapper):void
        {
            parseVariables(_arg_1, 9);
        }

        public function get locationX3D():int
        {
            return (getVariable(2));
        }

        public function get locationY3D():int
        {
            return (getVariable(3));
        }

        public function get direction():int
        {
            return (getVariable(4));
        }

        public function get height():int
        {
            return (getVariable(5));
        }

        public function get fuseObjectId():int
        {
            return (getVariable(6));
        }

        public function get maxHits():int
        {
            return (getVariable(7));
        }

        public function get hits():int
        {
            return (getVariable(8));
        }


    }
}

