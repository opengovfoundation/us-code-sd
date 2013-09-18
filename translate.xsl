<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xpath-default-namespace="http://xml.house.gov/schemas/uslm/1.0">
	<xsl:output indent="yes"/>
	<xsl:strip-space elements="*"/>

	<xsl:template match="@*|node()">
		<xsl:apply-templates select="@*|node()"/>
	</xsl:template>

	<xsl:template match="chapter/section">
		
		<xsl:variable name="href"> 
			<xsl:choose>
				<xsl:when test="preceding-sibling::section/num/@value = current()/num/@value">sd/<xsl:value-of select="ancestor::title/num/@value" />-<xsl:value-of select="ancestor::chapter/num/@value" />-<xsl:value-of select="num/@value" />(2).xml</xsl:when>
				<xsl:otherwise>sd/<xsl:value-of select="ancestor::title/num/@value" />-<xsl:value-of select="ancestor::chapter/num/@value" />-<xsl:value-of select="num/@value" />.xml</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
			
		<xsl:result-document href="{$href}">
			<law>
				<structure>
					<unit label="title" identifier="{ancestor::title/num/@value}" 
						order_by="{ancestor::title/num/@value}" level="1">
						<xsl:value-of select="concat(ancestor::title/num,' ',ancestor::title/heading)"/>
					</unit>
					<unit label="chapter" identifier="{ancestor::chapter/num/@value}"
						order_by="{ancestor::title/num/@value}" level="2">
						<xsl:value-of select="concat(ancestor::chapter/num, ' ', ancestor::chapter/heading)" />
					</unit>
				</structure>
				<section_number>
					<xsl:value-of select="num/@value" />
				</section_number>
				<catch_line>
					<xsl:value-of select="heading" />
				</catch_line>
				<order_by>
					<xsl:value-of select="num/@value" />
				</order_by>
				<!-- TODO: need to nest indented paragraphs -->
				<text>
					<xsl:for-each select="content/p">
						<section>
							<xsl:value-of select="text()"/>
						</section>
					</xsl:for-each>
					<!-- Begin heirarchy -->
					<!-- Subsection -->
					<xsl:for-each select="subsection">
						<section prefix="{current()/num/@value}">
							<xsl:value-of select="current()/content/text()" />
							<!-- Paragraph -->
							<xsl:for-each select="current()/paragraph">
								<section prefix="{current()/num/@value}">
									<xsl:value-of select="current()/content/text()" />
									<!-- Subparagraph -->
									<xsl:for-each select="current()/subparagraph">
										<section prefix="{current()/num/@value}">
											<xsl:value-of select="current()/content/text()" />
											<!-- Clause -->
											<xsl:for-each select="current()/clause">
												<section prefix="{current()/num/@value}">
													<xsl:value-of select="current()/content/text()" />
													<!-- Subclause -->
													<xsl:for-each select="current()/subclause">
														<section prefix="{current()/num/@value}">
															<xsl:value-of select="current()/content/text()" />
															<!-- Item -->
															<xsl:for-each select="current()/item">
																<section prefix="{current()/num/@value}">
																	<xsl:value-of select="current()/content/text()" />
																	<!-- Subitem -->
																	<xsl:for-each select="current()/subitem">
																		<section prefix="{current()/num/@value}">
																			<xsl:value-of select="current()/content/text()" />
																			<!-- SubSubitem -->
																			<xsl:for-each select="current()/subsubitem">
																				<section prefix="{current()/num/@value}">
																					<xsl:value-of select="current()/content/text()" />
																				</section>
																			</xsl:for-each>
																		</section>
																	</xsl:for-each>
																</section>
															</xsl:for-each>
														</section>
													</xsl:for-each>
												</section>
											</xsl:for-each>
										</section>
									</xsl:for-each>
								</section>
							</xsl:for-each>
						</section>
					</xsl:for-each>
				</text>
				<!-- TODO add history / metadata -->
			</law>
		</xsl:result-document>
	</xsl:template>
	
</xsl:stylesheet>