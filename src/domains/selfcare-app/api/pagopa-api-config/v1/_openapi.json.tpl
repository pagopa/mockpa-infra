openapi: 3.0.3
info:
  title: pagopa-selfcare-ms-backoffice
  description: PagoPa backoffice API documentation
  version: 0.0.78
servers:
  - url: 'https://${host}/${basePath}'
    description: Inferred Url
tags:
  - name: channels
    description: Api config channels operations
paths:
  '/channels':
    get:
      tags:
        - channels
      summary: getChannels
      description: Get paginated list of channels
      operationId: getChannelsUsingGET
      parameters:
        - name: limit
          in: query
          description: Number of elements on one page. Default = 50
          required: false
          style: form
          schema:
            type: integer
            format: int32
        - name: page
          in: query
          description: Page number. Page value starts from 0
          required: true
          style: form
          schema:
            type: integer
            format: int32
        - name: code
          in: query
          description: Filter chennel by code
          required: false
          style: form
          schema:
            type: string
        - name: ordering
          in: query
          description: Sort Direction ordering
          required: false
          style: form
          schema:
            type: string
        - name: X-Request-Id
          in: header
          description: internal request trace id
          required: false
          schema:
            type: string
      responses:
        '200':
          description: OK
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ChannelsResource'
        '400':
          description: Bad Request
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '401':
          description: Unauthorized
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '404':
          description: Not Found
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '500':
          description: Internal Server Error
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
      security:
        - bearerAuth:
            - global
    post:
      tags:
        - channels
      summary: createChannel
      description: Create a channel
      operationId: createChannelUsingPOST
      parameters:
        - name: X-Request-Id
          in: header
          description: internal request trace id
          required: false
          schema:
            type: string
      requestBody:
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/ChannelDetailsDto'
      responses:
        '201':
          description: Created
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ChannelDetailsResource'
        '400':
          description: Bad Request
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '401':
          description: Unauthorized
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '500':
          description: Internal Server Error
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
      security:
        - bearerAuth:
            - global
  '/channels/configuration/paymenttypes':
    get:
      tags:
        - channels
      summary: getPaymentTypes
      description: Get list of payment type
      operationId: getPaymentTypesUsingGET
      responses:
        '200':
          description: OK
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/PaymentTypesResource'
        '400':
          description: Bad Request
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '401':
          description: Unauthorized
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '404':
          description: Not Found
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '500':
          description: Internal Server Error
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
      security:
        - bearerAuth:
            - global
  '/channels/details/{channelcode}':
    get:
      tags:
        - channels
      summary: getChannelDetails
      operationId: getChannelDetailsUsingGET
      parameters:
        - name: channelcode
          in: path
          description: Code of the payment channel
          required: true
          style: simple
          schema:
            type: string
        - name: X-Request-Id
          in: header
          description: internal request trace id
          required: false
          schema:
            type: string
      responses:
        '200':
          description: OK
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ChannelDetailsResource'
        '400':
          description: Bad Request
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '401':
          description: Unauthorized
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '404':
          description: Not Found
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '500':
          description: Internal Server Error
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
      security:
        - bearerAuth:
            - global
  '/channels/paymenttypes/{channelcode}':
    get:
      tags:
        - channels
      summary: getChannelPaymentTypes
      description: Get list of payment type of a channel
      operationId: getChannelPaymentTypesUsingGET
      parameters:
        - name: channelcode
          in: path
          description: Channel's unique identifier
          required: true
          style: simple
          schema:
            type: string
      responses:
        '200':
          description: OK
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/PspChannelPaymentTypesResource'
        '400':
          description: Bad Request
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '401':
          description: Unauthorized
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '404':
          description: Not Found
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '500':
          description: Internal Server Error
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
      security:
        - bearerAuth:
            - global
  '/channels/psp/{channelcode}/{pspcode}':
    put:
      tags:
        - channels
      summary: updatePaymentServiceProvidersChannels
      description: Update a relation between a PSP and a channel
      operationId: updatePaymentServiceProvidersChannelsUsingPUT
      parameters:
        - name: channelcode
          in: path
          description: Channel's unique identifier
          required: true
          style: simple
          schema:
            type: string
        - name: pspcode
          in: path
          description: Code of the payment service provider
          required: true
          style: simple
          schema:
            type: string
      requestBody:
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/PspChannelPaymentTypes'
      responses:
        '200':
          description: OK
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/PspChannelPaymentTypesResource'
        '400':
          description: Bad Request
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '401':
          description: Unauthorized
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '500':
          description: Internal Server Error
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
      security:
        - bearerAuth:
            - global
    delete:
      tags:
        - channels
      summary: deletePaymentServiceProvidersChannels
      description: Delete a relation between a PSP and a channel
      operationId: deletePaymentServiceProvidersChannelsUsingDELETE
      parameters:
        - name: channelcode
          in: path
          description: Channel's unique identifier
          required: true
          style: simple
          schema:
            type: string
        - name: pspcode
          in: path
          description: Code of the payment service provider
          required: true
          style: simple
          schema:
            type: string
      responses:
        '200':
          description: OK
        '400':
          description: Bad Request
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '401':
          description: Unauthorized
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '500':
          description: Internal Server Error
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
      security:
        - bearerAuth:
            - global
  '/channels/{brokerpspcode}/paymentserviceproviders':
    get:
      tags:
        - channels
      summary: getPspBrokerPsp
      description: Get the PSP list of a broker
      operationId: getPspBrokerPspUsingGET
      parameters:
        - name: limit
          in: query
          description: Number of elements on one page. Default = 50
          required: false
          style: form
          schema:
            type: integer
            format: int32
        - name: page
          in: query
          description: Page number. Page value starts from 0
          required: true
          style: form
          schema:
            type: integer
            format: int32
        - name: brokerpspcode
          in: path
          description: Broker code of a PSP
          required: true
          style: simple
          schema:
            type: string
      responses:
        '200':
          description: OK
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/PaymentServiceProvidersResource'
        '400':
          description: Bad Request
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '401':
          description: Unauthorized
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '404':
          description: Not Found
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '500':
          description: Internal Server Error
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
      security:
        - bearerAuth:
            - global
  '/channels/{channelcode}':
    put:
      tags:
        - channels
      summary: updateChannel
      description: Create a channel
      operationId: updateChannelUsingPUT
      parameters:
        - name: channelcode
          in: path
          description: Channel's unique identifier
          required: true
          style: simple
          schema:
            type: string
      requestBody:
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/ChannelDetailsDto'
      responses:
        '200':
          description: OK
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ChannelDetailsResource'
        '400':
          description: Bad Request
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '401':
          description: Unauthorized
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '500':
          description: Internal Server Error
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
      security:
        - bearerAuth:
            - global
    delete:
      tags:
        - channels
      summary: deleteChannel
      description: delete channel
      operationId: deleteChannelUsingDELETE
      parameters:
        - name: channelcode
          in: path
          description: Code of the payment channel
          required: true
          style: simple
          schema:
            type: string
      responses:
        '200':
          description: OK
        '400':
          description: Bad Request
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '401':
          description: Unauthorized
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '500':
          description: Internal Server Error
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
      security:
        - bearerAuth:
            - global
  '/channels/{channelcode}/paymenttypes':
    post:
      tags:
        - channels
      summary: createChannelPaymentType
      description: Create a payment types of a channel
      operationId: createChannelPaymentTypeUsingPOST
      parameters:
        - name: channelcode
          in: path
          description: Channel's unique identifier
          required: true
          style: simple
          schema:
            type: string
      requestBody:
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/PspChannelPaymentTypes'
      responses:
        '201':
          description: Created
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/PspChannelPaymentTypesResource'
        '400':
          description: Bad Request
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '401':
          description: Unauthorized
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '500':
          description: Internal Server Error
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
      security:
        - bearerAuth:
            - global
  '/channels/{channelcode}/{paymenttypecode}':
    delete:
      tags:
        - channels
      summary: deleteChannelPaymentType
      description: delete payment type of a channel
      operationId: deleteChannelPaymentTypeUsingDELETE
      parameters:
        - name: channelcode
          in: path
          description: Channel's unique identifier
          required: true
          style: simple
          schema:
            type: string
        - name: paymenttypecode
          in: path
          description: Code of the payment type
          required: true
          style: simple
          schema:
            type: string
      responses:
        '200':
          description: OK
        '400':
          description: Bad Request
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '401':
          description: Unauthorized
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '500':
          description: Internal Server Error
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
      security:
        - bearerAuth:
            - global
  '/channels/{pspcode}':
    get:
      tags:
        - channels
      summary: getPspChannels
      operationId: getPspChannelsUsingGET
      parameters:
        - name: pspcode
          in: path
          description: Code of the payment service provider
          required: true
          style: simple
          schema:
            type: string
        - name: X-Request-Id
          in: header
          description: internal request trace id
          required: false
          schema:
            type: string
      responses:
        '200':
          description: OK
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/PspChannelsResource'
        '400':
          description: Bad Request
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '401':
          description: Unauthorized
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '404':
          description: Not Found
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
        '500':
          description: Internal Server Error
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/Problem'
      security:
        - bearerAuth:
            - global
components:
  schemas:
    ChannelDetailsDto:
      title: ChannelDetailsDto
      type: object
      properties:
        agid:
          type: boolean
          description: agid
          example: false
        broker_description:
          type: string
          description: Broker description. Read only field
        broker_psp_code:
          type: string
          description: 'psp code '
        card_chart:
          type: boolean
          description: card chart
          example: false
        channel_code:
          type: string
          description: Channel code
        digital_stamp_brand:
          type: boolean
          description: digital stamp brand
          example: false
        enabled:
          type: boolean
        flag_io:
          type: boolean
          description: flag io
          example: false
        ip:
          type: string
          description: channel's ip
        new_fault_code:
          type: boolean
          description: new fault code
          example: false
        new_password:
          type: string
          description: channel's new password
        npm_service:
          type: string
          description: npm service
        on_us:
          type: boolean
          description: on us
          example: false
        password:
          type: string
          description: channel's password
        payment_model:
          type: string
          description: payment model
          enum:
            - ACTIVATED_AT_PSP
            - DEFERRED
            - IMMEDIATE
            - IMMEDIATE_MULTIBENEFICIARY
        payment_types:
          type: array
          description: List of payment types
          items:
            type: string
        port:
          type: integer
          description: channel's port
          format: int64
        primitive_version:
          type: string
          description: primitive version
        protocol:
          type: string
          description: channel's protocol
          enum:
            - HTTP
            - HTTPS
        proxy_enabled:
          type: boolean
          description: proxy Enabled
          example: false
        proxy_host:
          type: string
          description: proxy Host
        proxy_password:
          type: string
          description: proxy Password
        proxy_port:
          type: integer
          description: proxy Port
          format: int64
        proxy_username:
          type: string
          description: proxy Username
        recovery:
          type: boolean
          description: recovery
          example: false
        redirect_ip:
          type: string
          description: redirect ip
        redirect_path:
          type: string
          description: redirect path
        redirect_port:
          type: integer
          description: redirect port
          format: int64
        redirect_protocol:
          type: string
          description: redirect protocol
          enum:
            - HTTP
            - HTTPS
        redirect_query_string:
          type: string
          description: redirect query string
        rt_push:
          type: boolean
          description: rt Push
          example: false
        serv_plugin:
          type: string
          description: service plugin
        service:
          type: string
          description: channel's service
        target_host:
          type: string
          description: target host
        target_path:
          type: string
          description: target path's
        target_port:
          type: integer
          description: target port
          format: int64
        thread_number:
          type: integer
          description: thread number
          format: int64
        timeout_a:
          type: integer
          description: timeout A
          format: int64
        timeout_b:
          type: integer
          description: timeout B
          format: int64
        timeout_c:
          type: integer
          description: timeout C
          format: int64
    ChannelDetailsResource:
      title: ChannelDetailsResource
      type: object
      properties:
        agid:
          type: boolean
          description: agid
          example: false
        broker_description:
          type: string
          description: Broker description. Read only field
        broker_psp_code:
          type: string
          description: 'psp code '
        card_chart:
          type: boolean
          description: card chart
          example: false
        channel_code:
          type: string
          description: Channel code
        digital_stamp_brand:
          type: boolean
          description: digital stamp brand
          example: false
        enabled:
          type: boolean
        flag_io:
          type: boolean
          description: flag io
          example: false
        ip:
          type: string
          description: channel's ip
        new_fault_code:
          type: boolean
          description: new fault code
          example: false
        new_password:
          type: string
          description: channel's new password
        npm_service:
          type: string
          description: npm service
        on_us:
          type: boolean
          description: on us
          example: false
        password:
          type: string
          description: channel's password
        payment_model:
          type: string
          description: payment model
          enum:
            - ACTIVATED_AT_PSP
            - DEFERRED
            - IMMEDIATE
            - IMMEDIATE_MULTIBENEFICIARY
        payment_types:
          type: array
          description: List of payment types
          items:
            type: string
        port:
          type: integer
          description: channel's port
          format: int64
        primitive_version:
          type: string
          description: primitive version
        protocol:
          type: string
          description: channel's protocol
          enum:
            - HTTP
            - HTTPS
        proxy_enabled:
          type: boolean
          description: proxy Enabled
          example: false
        proxy_host:
          type: string
          description: proxy Host
        proxy_password:
          type: string
          description: proxy Password
        proxy_port:
          type: integer
          description: proxy Port
          format: int64
        proxy_username:
          type: string
          description: proxy Username
        recovery:
          type: boolean
          description: recovery
          example: false
        redirect_ip:
          type: string
          description: redirect ip
        redirect_path:
          type: string
          description: redirect path
        redirect_port:
          type: integer
          description: redirect port
          format: int64
        redirect_protocol:
          type: string
          description: redirect protocol
          enum:
            - HTTP
            - HTTPS
        redirect_query_string:
          type: string
          description: redirect query string
        rt_push:
          type: boolean
          description: rt Push
          example: false
        serv_plugin:
          type: string
          description: service plugin
        service:
          type: string
          description: channel's service
        target_host:
          type: string
          description: target host
        target_path:
          type: string
          description: target path's
        target_port:
          type: integer
          description: target port
          format: int64
        thread_number:
          type: integer
          description: thread number
          format: int64
        timeout_a:
          type: integer
          description: timeout A
          format: int64
        timeout_b:
          type: integer
          description: timeout B
          format: int64
        timeout_c:
          type: integer
          description: timeout C
          format: int64
    ChannelResource:
      title: ChannelResource
      type: object
      properties:
        broker_description:
          type: string
          description: Broker description. Read only field
        channel_code:
          type: string
          description: Channel code
        enabled:
          type: boolean
    ChannelsResource:
      title: ChannelsResource
      required:
        - channels
        - page_info
      type: object
      properties:
        channels:
          type: array
          description: list of psp and ec channels
          items:
            $ref: '#/components/schemas/ChannelResource'
        page_info:
          description: info pageable
          $ref: '#/components/schemas/PageInfo'
    InvalidParam:
      title: InvalidParam
      required:
        - name
        - reason
      type: object
      properties:
        name:
          type: string
          description: Invalid parameter name.
        reason:
          type: string
          description: Invalid parameter reason.
    PageInfo:
      title: PageInfo
      type: object
      properties:
        items_found:
          type: integer
          format: int32
        limit:
          type: integer
          format: int32
        page:
          type: integer
          format: int32
        total_pages:
          type: integer
          format: int32
    PaymentServiceProviderResource:
      title: PaymentServiceProviderResource
      type: object
      properties:
        business_name:
          type: string
        enabled:
          type: boolean
        psp_code:
          type: string
    PaymentServiceProvidersResource:
      title: PaymentServiceProvidersResource
      type: object
      properties:
        page_info:
          $ref: '#/components/schemas/PageInfo'
        payment_service_providers:
          type: array
          items:
            $ref: '#/components/schemas/PaymentServiceProviderResource'
    PaymentTypeResource:
      title: PaymentTypeResource
      required:
        - description
        - payment_type
      type: object
      properties:
        description:
          type: string
          description: Description of the payment type
        payment_type:
          type: string
          description: Code of payment type
    PaymentTypesResource:
      title: PaymentTypesResource
      required:
        - payment_types
      type: object
      properties:
        payment_types:
          type: array
          description: List of payment types
          items:
            $ref: '#/components/schemas/PaymentTypeResource'
    Problem:
      title: Problem
      required:
        - status
        - title
      type: object
      properties:
        detail:
          type: string
          description: Human-readable description of this specific problem.
        instance:
          type: string
          description: A URI that describes where the problem occurred.
        invalidParams:
          type: array
          description: A list of invalid parameters details.
          items:
            $ref: '#/components/schemas/InvalidParam'
        status:
          type: integer
          description: The HTTP status code.
          format: int32
          example: 500
        title:
          type: string
          description: Short human-readable summary of the problem.
        type:
          type: string
          description: A URL to a page with more details regarding the problem.
      description: A "problem detail" as a way to carry machine-readable details of errors (https://datatracker.ietf.org/doc/html/rfc7807)
    PspChannelPaymentTypes:
      title: PspChannelPaymentTypes
      type: object
      properties:
        payment_types:
          type: array
          items:
            type: string
    PspChannelPaymentTypesResource:
      title: PspChannelPaymentTypesResource
      required:
        - payment_types
      type: object
      properties:
        payment_types:
          type: array
          description: List of payment types
          items:
            type: string
    PspChannelResource:
      title: PspChannelResource
      required:
        - channel_code
        - enabled
        - payment_types
      type: object
      properties:
        channel_code:
          type: string
          description: Channel's unique identifier
        enabled:
          type: boolean
          description: Channel enabled
          example: false
        payment_types:
          type: array
          description: List of payment types
          items:
            type: string
    PspChannelsResource:
      title: PspChannelsResource
      required:
        - channels
      type: object
      properties:
        channels:
          type: array
          description: Channel list
          items:
            $ref: '#/components/schemas/PspChannelResource'
  securitySchemes:
    bearerAuth:
      type: http
      description: A bearer token in the format of a JWS and conformed to the specifications included in [RFC8725](https://tools.ietf.org/html/RFC8725)
      scheme: bearer
      bearerFormat: JWT
