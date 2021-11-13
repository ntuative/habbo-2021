package com.sulake.habbo.communication.messages.parser.game.snowwar.data.object
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class SnowWarGameObjectData 
    {

        public static const _SafeStr_2014:int = 1;
        public static const _SafeStr_2015:int = 2;
        public static const _SafeStr_2016:int = 3;
        public static const _SafeStr_2017:int = 4;
        public static const _SafeStr_2018:int = 5;

        protected var _SafeStr_2013:Array = [];

        public function SnowWarGameObjectData(_arg_1:int, _arg_2:int)
        {
            setVariable(0, _arg_1);
            setVariable(1, _arg_2);
        }

        public static function create(_arg_1:int, _arg_2:int):SnowWarGameObjectData
        {
            switch (_arg_1)
            {
                case 1:
                    return (new SnowballGameObjectData(_arg_1, _arg_2));
                case 4:
                    return (new SnowballMachineGameObjectData(_arg_1, _arg_2));
                case 3:
                    return (new SnowballPileGameObjectData(_arg_1, _arg_2));
                case 5:
                    return (new HumanGameObjectData(_arg_1, _arg_2));
                case 2:
                    return (new TreeGameObjectData(_arg_1, _arg_2));
                default:
                    return (null);
            };
        }


        public function get type():int
        {
            return (getVariable(0));
        }

        public function get id():int
        {
            return (getVariable(1));
        }

        public function getVariable(_arg_1:int):int
        {
            return (_SafeStr_2013[_arg_1]);
        }

        protected function setVariable(_arg_1:int, _arg_2:int):void
        {
            _SafeStr_2013[_arg_1] = _arg_2;
        }

        protected function parseVariables(_arg_1:IMessageDataWrapper, _arg_2:int):void
        {
            var _local_3:int;
            _local_3 = 2;
            while (_local_3 < _arg_2)
            {
                _SafeStr_2013.push(_arg_1.readInteger());
                _local_3++;
            };
        }

        public function parse(_arg_1:IMessageDataWrapper):void
        {
        }


    }
}

