package com.sulake.habbo.communication.messages.parser.callforhelp
{
    import com.sulake.core.communication.messages.IMessageParser;
    import __AS3__.vec.Vector;
    import com.sulake.habbo.communication.messages.incoming.callforhelp.CallForHelpCategoryData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class CfhTopicsInitMessageParser implements IMessageParser 
    {

        private var _callForHelpCategories:Vector.<CallForHelpCategoryData>;
        private var _disposed:Boolean;


        public function flush():Boolean
        {
            if (_disposed)
            {
                return (true);
            };
            _disposed = true;
            for each (var _local_1:CallForHelpCategoryData in _callForHelpCategories)
            {
                _local_1.dispose();
            };
            _callForHelpCategories = null;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_3:int;
            _callForHelpCategories = new Vector.<CallForHelpCategoryData>();
            var _local_2:int = _arg_1.readInteger();
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                _callForHelpCategories.push(new CallForHelpCategoryData(_arg_1));
                _local_3++;
            };
            return (true);
        }

        public function get callForHelpCategories():Vector.<CallForHelpCategoryData>
        {
            return (_callForHelpCategories);
        }


    }
}