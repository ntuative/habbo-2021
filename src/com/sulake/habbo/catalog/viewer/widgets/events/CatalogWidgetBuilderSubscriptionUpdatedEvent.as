package com.sulake.habbo.catalog.viewer.widgets.events
{
    import flash.events.Event;

    public class CatalogWidgetBuilderSubscriptionUpdatedEvent extends Event 
    {

        public function CatalogWidgetBuilderSubscriptionUpdatedEvent(_arg_1:Boolean=false, _arg_2:Boolean=false)
        {
            super("CWE_BUILDER_SUBSCRIPTION_UPDATED", _arg_1, _arg_2);
        }

    }
}