package com.sulake.habbo.communication.messages.incoming.catalog
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.catalog.BuildersClubFurniCountMessageParser;

        public class BuildersClubFurniCountMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function BuildersClubFurniCountMessageEvent(_arg_1:Function)
        {
            super(_arg_1, BuildersClubFurniCountMessageParser);
        }

        public function getParser():BuildersClubFurniCountMessageParser
        {
            return (this._SafeStr_816 as BuildersClubFurniCountMessageParser);
        }


    }
}

