package com.sulake.habbo.communication.messages.incoming.catalog
{
    import __AS3__.vec.Vector;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class NodeData 
    {

        private var _visible:Boolean;
        private var _icon:int;
        private var _pageId:int;
        private var _pageName:String;
        private var _localization:String;
        private var _children:Vector.<NodeData>;
        private var _offerIds:Vector.<int>;

        public function NodeData(_arg_1:IMessageDataWrapper)
        {
            var _local_3:int;
            super();
            _visible = _arg_1.readBoolean();
            _icon = _arg_1.readInteger();
            _pageId = _arg_1.readInteger();
            _pageName = _arg_1.readString();
            _localization = _arg_1.readString();
            _offerIds = new Vector.<int>(0);
            var _local_2:int = _arg_1.readInteger();
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                _offerIds.push(_arg_1.readInteger());
                _local_3++;
            };
            _children = new Vector.<NodeData>(0);
            var _local_4:int = _arg_1.readInteger();
            _local_3 = 0;
            while (_local_3 < _local_4)
            {
                _children.push(new NodeData(_arg_1));
                _local_3++;
            };
        }

        public function get visible():Boolean
        {
            return (_visible);
        }

        public function get icon():int
        {
            return (_icon);
        }

        public function get pageId():int
        {
            return (_pageId);
        }

        public function get pageName():String
        {
            return (_pageName);
        }

        public function get localization():String
        {
            return (_localization);
        }

        public function get children():Vector.<NodeData>
        {
            return (_children);
        }

        public function get offerIds():Vector.<int>
        {
            return (_offerIds);
        }


    }
}