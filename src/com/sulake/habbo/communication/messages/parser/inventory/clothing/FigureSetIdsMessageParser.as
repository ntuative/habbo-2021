package com.sulake.habbo.communication.messages.parser.inventory.clothing
{
    import com.sulake.core.communication.messages.IMessageParser;
    import __AS3__.vec.Vector;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class FigureSetIdsMessageParser implements IMessageParser 
    {

        private var _figureSetIds:Vector.<int>;
        private var _boundFurnitureNames:Vector.<String>;


        public function flush():Boolean
        {
            _figureSetIds = new Vector.<int>(0);
            _boundFurnitureNames = new Vector.<String>(0);
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_3:int;
            var _local_2:int = _arg_1.readInteger();
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                _figureSetIds.push(_arg_1.readInteger());
                _local_3++;
            };
            _local_2 = _arg_1.readInteger();
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                _boundFurnitureNames.push(_arg_1.readString());
                _local_3++;
            };
            return (true);
        }

        public function get figureSetIds():Vector.<int>
        {
            return (_figureSetIds);
        }

        public function get boundFurnitureNames():Vector.<String>
        {
            return (_boundFurnitureNames);
        }


    }
}