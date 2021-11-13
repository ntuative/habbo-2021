package com.sulake.habbo.communication.messages.parser.competition
{
    import com.sulake.core.communication.messages.IMessageParser;
    import flash.utils.Dictionary;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class CompetitionEntrySubmitResultMessageParser implements IMessageParser 
    {

        public static const _SafeStr_1961:int = 0;
        public static const _SafeStr_1962:int = 1;
        public static const _SafeStr_1963:int = 2;
        public static const _SafeStr_1964:int = 3;
        public static const _SafeStr_1965:int = 4;
        public static const _SafeStr_1966:int = 5;
        public static const _SafeStr_1967:int = 6;

        private var _goalId:int;
        private var _goalCode:String;
        private var _result:int;
        private var _requiredFurnis:Array;
        private var _SafeStr_1968:Dictionary;


        public function flush():Boolean
        {
            _requiredFurnis = null;
            _SafeStr_1968 = null;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_2:int;
            _goalId = _arg_1.readInteger();
            _goalCode = _arg_1.readString();
            _result = _arg_1.readInteger();
            _requiredFurnis = [];
            var _local_3:int = _arg_1.readInteger();
            _local_2 = 0;
            while (_local_2 < _local_3)
            {
                _requiredFurnis.push(_arg_1.readString());
                _local_2++;
            };
            _SafeStr_1968 = new Dictionary();
            _local_3 = _arg_1.readInteger();
            _local_2 = 0;
            while (_local_2 < _local_3)
            {
                _SafeStr_1968[_arg_1.readString()] = "";
                _local_2++;
            };
            return (true);
        }

        public function get goalId():int
        {
            return (_goalId);
        }

        public function get goalCode():String
        {
            return (_goalCode);
        }

        public function get result():int
        {
            return (_result);
        }

        public function get requiredFurnis():Array
        {
            return (_requiredFurnis);
        }

        public function isMissing(_arg_1:String):Boolean
        {
            return (!(_SafeStr_1968[_arg_1] == null));
        }


    }
}

