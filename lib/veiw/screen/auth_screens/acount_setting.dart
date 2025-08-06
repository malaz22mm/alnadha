
import 'package:flutter/material.dart';

import '../../../core/constant/colors.dart';




class AccountEditWidget extends StatefulWidget {
  const AccountEditWidget({super.key});



  @override
  State<AccountEditWidget> createState() => _AccountEditWidgetState();
}

class _AccountEditWidgetState extends State<AccountEditWidget> {


  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor:AppColors.primarycolor ,
        body: SafeArea(
          top: true,
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Stack(
              alignment: const AlignmentDirectional(1, -1),
              children: [
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: const BoxDecoration(),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [


                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Align(
                                alignment: AlignmentDirectional(-1, 0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16, 0, 0, 0),


                                ),
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                  color: AppColors.darkbluecolor,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {

                                      },
                                      child: Container(
                                        decoration: const BoxDecoration(),
                                        child: const Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Material(
                                              color: Colors.transparent,
                                              child: ListTile(
                                                title: Text(
                                                  'First name',

                                                ),
                                                subtitle: Text(
                                              'ddd'
                                                ),
                                                trailing: Icon(
                                                 Icons.add,
                                                  size: 12,
                                                ),

                                              ),
                                            ),

                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      decoration: const BoxDecoration(),
                                      child: const Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [

                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          16, 0, 16, 0),
                                      child: InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {

                                        },
                                        child: Container(
                                          width: double.infinity,
                                          decoration: const BoxDecoration(
                                            color:AppColors.primarycolor
                                          ),
                                          child: const Padding(
                                            padding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                0, 8, 0, 8),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    mainAxisSize:
                                                    MainAxisSize.max,
                                                    children: [
                                                      Row(
                                                        mainAxisSize:
                                                        MainAxisSize.max,
                                                        children: [
                                                          Flexible(
                                                            child: Text(
                                                              'Phone number',

                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisSize:
                                                        MainAxisSize.max,
                                                        children: [
                                                          Flexible(
                                                            child: Text(
                                                              '+44 01234 56789',

                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ]
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          16, 0, 16, 0),
                                      child: InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {

                                        },
                                        child: Container(
                                          width: double.infinity,
                                          decoration: const BoxDecoration(
                                            color: AppColors.primarycolor
                                          ),
                                          child: const Padding(
                                            padding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                0, 8, 0, 8),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    mainAxisSize:
                                                    MainAxisSize.max,
                                                    children: [
                                                      Row(
                                                        mainAxisSize:
                                                        MainAxisSize.max,
                                                        children: [
                                                          Flexible(
                                                            child: Text(
                                                              'Email address',

                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisSize:
                                                        MainAxisSize.max,
                                                        children: [
                                                          Flexible(
                                                            child: Text(
                                                              'dolly@uiclones.com',

                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ]
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          16, 0, 16, 0),
                                      child: InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {

                                        },
                                        child: Container(
                                          width: double.infinity,
                                          decoration: const BoxDecoration(
                                            color: AppColors.primarycolor,
                                          ),
                                          child: const Padding(
                                            padding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                0, 8, 0, 8),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    mainAxisSize:
                                                    MainAxisSize.max,
                                                    children: [
                                                      Row(
                                                        mainAxisSize:
                                                        MainAxisSize.max,
                                                        children: [
                                                          Flexible(
                                                            child: Text(
                                                              'Password',

                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisSize:
                                                        MainAxisSize.max,
                                                        children: [
                                                          Flexible(
                                                            child: Text(
                                                              '*********',

                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ]
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisSize:
                                                  MainAxisSize.max,
                                                  children: [
                                                    Icon(
                                                     Icons.password,
                                                      size: 12,
                                                    ),
                                                  ]
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ]


                          ),
                        ),
                      ),
                    ]

                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
