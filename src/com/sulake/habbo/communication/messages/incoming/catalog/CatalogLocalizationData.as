package com.sulake.habbo.communication.messages.incoming.catalog
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class CatalogLocalizationData 
    {

        private var _images:Array;
        private var _texts:Array;

        public function CatalogLocalizationData(_arg_1:IMessageDataWrapper)
        {
            var _local_3:int;
            var _local_5:int;
            super();
            _images = [];
            _texts = [];
            var _local_2:int = _arg_1.readInteger();
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                _images.push(_arg_1.readString());
                _local_3++;
            };
            var _local_4:int = _arg_1.readInteger();
            _local_5 = 0;
            while (_local_5 < _local_4)
            {
                _texts.push(_arg_1.readString());
                _local_5++;
            };
        }

        public function get images():Array
        {
            return (_images);
        }

        public function get texts():Array
        {
            return (_texts);
        }


    }
}