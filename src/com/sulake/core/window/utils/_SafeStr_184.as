package com.sulake.core.window.utils
{
    import com.sulake.core.window.enum._SafeStr_112;
    import flash.utils.Dictionary;

    public class _SafeStr_184 extends _SafeStr_112 
    {


        public static function fillTables(_arg_1:Dictionary, _arg_2:Dictionary=null):void
        {
            var _local_3:String;
            _arg_1["background"] = 2;
            _arg_1["bitmap"] = 21;
            _arg_1["border"] = 30;
            _arg_1["boxsizer"] = 17;
            _arg_1["border_notify"] = 33;
            _arg_1["bubble"] = 45;
            _arg_1["bubble_pointer_up"] = 46;
            _arg_1["bubble_pointer_right"] = 47;
            _arg_1["bubble_pointer_down"] = 48;
            _arg_1["bubble_pointer_left"] = 49;
            _arg_1["button"] = 60;
            _arg_1["button_thick"] = 61;
            _arg_1["button_icon"] = 62;
            _arg_1["button_group_left"] = 67;
            _arg_1["button_group_center"] = 68;
            _arg_1["button_group_right"] = 69;
            _arg_1["checkbox"] = 70;
            _arg_1["closebutton"] = 72;
            _arg_1["container"] = 4;
            _arg_1["container_button"] = 41;
            _arg_1["display_object_wrapper"] = 20;
            _arg_1["dropmenu"] = 102;
            _arg_1["dropmenu_item"] = 103;
            _arg_1["droplist"] = 105;
            _arg_1["droplist_item"] = 106;
            _arg_1["formatted_text"] = 15;
            _arg_1["frame"] = 35;
            _arg_1["frame_notify"] = 38;
            _arg_1["header"] = 6;
            _arg_1["html"] = 11;
            _arg_1["icon"] = 1;
            _arg_1["itemgrid"] = 52;
            _arg_1["itemgrid_horizontal"] = 54;
            _arg_1["itemgrid_vertical"] = 53;
            _arg_1["itemlist"] = 50;
            _arg_1["itemlist_horizontal"] = 51;
            _arg_1["itemlist_vertical"] = 50;
            _arg_1["label"] = 12;
            _arg_1["maximizebox"] = 74;
            _arg_1["menu"] = 100;
            _arg_1["menu_item"] = 101;
            _arg_1["submenu"] = 104;
            _arg_1["minimizebox"] = 73;
            _arg_1["notify"] = 9;
            _arg_1["null"] = 0;
            _arg_1["password"] = 78;
            _arg_1["radiobutton"] = 71;
            _arg_1["region"] = 5;
            _arg_1["restorebox"] = 75;
            _arg_1["scaler"] = 120;
            _arg_1["scaler_horizontal"] = 122;
            _arg_1["scaler_vertical"] = 121;
            _arg_1["scrollbar_horizontal"] = 130;
            _arg_1["scrollbar_vertical"] = 131;
            _arg_1["scrollbar_slider_button_up"] = 139;
            _arg_1["scrollbar_slider_button_down"] = 137;
            _arg_1["scrollbar_slider_button_left"] = 138;
            _arg_1["scrollbar_slider_button_right"] = 136;
            _arg_1["scrollbar_slider_bar_horizontal"] = 132;
            _arg_1["scrollbar_slider_bar_vertical"] = 133;
            _arg_1["scrollbar_slider_track_horizontal"] = 134;
            _arg_1["scrollbar_slider_track_vertical"] = 135;
            _arg_1["scrollable_itemlist"] = 55;
            _arg_1["scrollable_itemlist_vertical"] = 56;
            _arg_1["scrollable_itemgrid_vertical"] = 140;
            _arg_1["scrollable_itemlist_horizontal"] = 57;
            _arg_1["selector"] = 42;
            _arg_1["selector_list"] = 43;
            _arg_1["static_bitmap"] = 23;
            _arg_1["submenu"] = 104;
            _arg_1["tab_button"] = 93;
            _arg_1["tab_container_button"] = 94;
            _arg_1["tab_context"] = 91;
            _arg_1["tab_content"] = 90;
            _arg_1["tab_selector"] = 92;
            _arg_1["text"] = 10;
            _arg_1["input"] = 77;
            _arg_1["link"] = 14;
            _arg_1["toolbar"] = 7;
            _arg_1["tooltip"] = 8;
            _arg_1["widget"] = 16;
            if (_arg_2 != null)
            {
                for (_local_3 in _arg_1)
                {
                    _arg_2[_arg_1[_local_3]] = _local_3;
                };
            };
        }


    }
}

