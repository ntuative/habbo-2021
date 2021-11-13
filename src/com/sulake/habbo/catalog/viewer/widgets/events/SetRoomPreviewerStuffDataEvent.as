package com.sulake.habbo.catalog.viewer.widgets.events
{
    import flash.events.Event;
    import com.sulake.habbo.room.IStuffData;

    public class SetRoomPreviewerStuffDataEvent extends Event 
    {

        private var _stuffData:IStuffData;

        public function SetRoomPreviewerStuffDataEvent(_arg_1:IStuffData, _arg_2:Boolean=false, _arg_3:Boolean=false)
        {
            super("CWE_SET_PREVIEWER_STUFFDATA", _arg_2, _arg_3);
            _stuffData = _arg_1;
        }

        public function get stuffData():IStuffData
        {
            return (_stuffData);
        }


    }
}