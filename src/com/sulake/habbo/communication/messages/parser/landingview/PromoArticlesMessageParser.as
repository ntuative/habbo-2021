package com.sulake.habbo.communication.messages.parser.landingview
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.landingview.PromoArticleData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class PromoArticlesMessageParser implements IMessageParser 
    {

        private var _articles:Array;


        public function get articles():Array
        {
            return (_articles);
        }

        public function flush():Boolean
        {
            _articles = [];
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_3:int;
            var _local_2:int = _arg_1.readInteger();
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                _articles.push(new PromoArticleData(_arg_1));
                _local_3++;
            };
            return (true);
        }


    }
}