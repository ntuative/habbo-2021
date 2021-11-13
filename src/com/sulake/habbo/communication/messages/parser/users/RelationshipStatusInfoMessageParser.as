package com.sulake.habbo.communication.messages.parser.users
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.communication.messages.incoming.users.RelationshipStatusInfo;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class RelationshipStatusInfoMessageParser implements IMessageParser 
    {

        private var _userId:int;
        private var _relationshipStatusMap:Map;


        public function flush():Boolean
        {
            if (_relationshipStatusMap)
            {
                _relationshipStatusMap.dispose();
                _relationshipStatusMap = null;
            };
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_3:int;
            var _local_4:RelationshipStatusInfo;
            _userId = _arg_1.readInteger();
            _relationshipStatusMap = new Map();
            var _local_2:int = _arg_1.readInteger();
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                _local_4 = new RelationshipStatusInfo(_arg_1);
                _relationshipStatusMap.add(_local_4.relationshipStatusType, _local_4);
                _local_3++;
            };
            return (true);
        }

        public function get userId():int
        {
            return (_userId);
        }

        public function get relationshipStatusMap():Map
        {
            return (_relationshipStatusMap);
        }


    }
}