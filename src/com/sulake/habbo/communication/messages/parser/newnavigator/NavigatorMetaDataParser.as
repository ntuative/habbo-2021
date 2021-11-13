package com.sulake.habbo.communication.messages.parser.newnavigator
{
    import com.sulake.core.communication.messages.IMessageParser;
    import __AS3__.vec.Vector;
    import com.sulake.habbo.communication.messages.incoming.newnavigator.TopLevelContext;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class NavigatorMetaDataParser implements IMessageParser 
    {

        private var _topLevelContexts:Vector.<TopLevelContext>;


        public function flush():Boolean
        {
            _topLevelContexts = new Vector.<TopLevelContext>(0);
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_3:int;
            var _local_2:int = _arg_1.readInteger();
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                _topLevelContexts.push(new TopLevelContext(_arg_1));
                _local_3++;
            };
            return (true);
        }

        public function get topLevelContexts():Vector.<TopLevelContext>
        {
            return (_topLevelContexts);
        }


    }
}