package com.sulake.habbo.groups.events
{
    import flash.events.Event;

    public class HabboGroupsEditorData extends Event 
    {

        public static const EDIT_INFO:String = "HGE_EDIT_INFO";

        public function HabboGroupsEditorData(_arg_1:Boolean=false, _arg_2:Boolean=false)
        {
            super("HGE_EDIT_INFO", _arg_1, _arg_2);
        }

    }
}