<dsp:page>
  <dsp:importbean bean="/atg/dynamo/droplet/IsEmpty"/>

  <dsp:setvalue param="promoInformation" paramvalue="promoInformation"/>
  <dsp:droplet name="IsEmpty">
    <dsp:param name="value" param="promoInformation.htmlUrl"/>
    <dsp:oparam name="false">
      <div class="advertiseBlocks">
        <dsp:include page="../layoutTypeInformation.jsp">
          <dsp:param name="promoInformation" param="promoInformation"/>
        </dsp:include>
      </div>
    </dsp:oparam>
  </dsp:droplet>
</dsp:page>
